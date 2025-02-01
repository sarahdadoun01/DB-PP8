CREATE OR REPLACE PACKAGE BODY manlika IS

    -- Creates new Order
    PROCEDURE create_new_order(current_c_id NUMBER,current_meth_pmt VARCHAR2, current_os_id NUMBER) AS
        
    BEGIN
        SELECT manlika_sequence.NEXTVAL 
        INTO   global_order_id
        FROM dual;

        INSERT INTO orders
       	VALUES(global_order_id, sysdate, current_meth_pmt, current_c_id, current_os_id);
        COMMIT;
        qualify_or_not;
    END create_new_order;

    -- Verifes If QOH is >= Order Quantity
    FUNCTION verify_qoh(p_qoh NUMBER) RETURN BOOLEAN IS
	    result BOOLEAN := FALSE;
    BEGIN
        IF p_qoh >= global_quantity THEN
            result := TRUE;
        ELSE
            result := FALSE;
        END IF;
	    RETURN result;
    END verify_qoh;

    -- Verifies If QOH qualifies for new order
    PROCEDURE qualify_or_not AS
        v_qoh inventory.inv_qoh%TYPE;
    BEGIN
        SELECT inv_qoh 
        INTO v_qoh 
        FROM inventory
        WHERE inv_id = global_inv_id;

        IF verify_qoh(v_qoh) THEN
		    create_new_order_line(global_order_id);
            update_inventory;
	    ELSE
		    DBMS_OUTPUT.PUT_LINE('Not enough stock to continue with order.');
	    END IF;
    END qualify_or_not;

    -- Update order 
    PROCEDURE update_inventory AS
    BEGIN
        UPDATE inventory
        SET inv_qoh = inv_qoh - global_quantity
        WHERE inv_id = global_inv_id;
    END update_inventory;

    -- Creates New Order Line
    PROCEDURE create_new_order_line(current_o_id NUMBER) AS
    BEGIN
        INSERT INTO order_line
        VALUES(current_o_id, global_inv_id, global_quantity);
        COMMIT;
    END create_new_order_line;

END;
/