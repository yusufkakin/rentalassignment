-- QUESTION 1

INSERT INTO rental_records (rental_id, veh_reg_no, customer_id, start_date, end_date, lastUpdated) VALUES(6, 'SBA1111A',(SELECT customer_id from customers WHERE name = 'Angel'), NOW(), DATE_ADD(CURDATE(), INTERVAL 10 DAY), NOW());

-- QUESTION 2

INSERT INTO rental_records (veh_reg_no, customer_id, start_date, end_date, lastUpdated) VALUES('GA5555E',(SELECT customer_id from customers WHERE name = 'Kumar'), NOW(), DATE_ADD(CURDATE(), INTERVAL 3 MONTH), NOW());

-- QUESTION 3

SELECT 
    rental_records.start_date,
    rental_records.end_date,
    vehicles.veh_reg_no,
    vehicles.brand,
    customers.name
FROM
    rental_records
        INNER JOIN
    vehicles ON rental_records.veh_reg_no = vehicles.veh_reg_no
        INNER JOIN
    customers ON customers.customer_id = rental_records.customer_id
ORDER BY vehicles.category , rental_recrods.start_date;

-- QUESTION 4

SELECT 
    *
FROM
    rental_records
WHERE
    end_date < CURDATE();

-- QUESTION 5

SELECT 
    rental_records.veh_reg_no,
    customers.name,
    rental_records.start_date,
    rental_records.end_date
FROM
    rental_records
        INNER JOIN
    Vehicles USING (veh_reg_no)
        INNER JOIN
    Customers USING (customer_id)
WHERE
    '2012-01-10' BETWEEN rental_records.start_date AND rental_records.end_date;

-- QUESTION 6

SELECT 
    rental_records.veh_reg_no,
    customers.name,
    rental_records.start_date,
    rental_records.end_date
FROM
    rental_records
        INNER JOIN
    vehicles ON vehicles.veh_reg_no = rental_records.veh_reg_no
        INNER JOIN
    customers ON customers.customer_id = rental_records.customer_id
WHERE
    rental_records.start_date = '2022-04-28';


-- QUESTION 7

SELECT 
    rental_records.veh_reg_no,
    customers.name,
    rental_records.start_date,
    rental_records.end_date
FROM
    rental_records,
    customers
WHERE
    rental_records.start_date BETWEEN '2012-01-03' AND '2012-01-18'
        OR rental_records.end_date BETWEEN '2012-01-03' AND '2012-01-18'
        OR rental_records.start_date < '2012-01-03'
        AND rental_records.end_date > '2012-01-18';

-- QUESTION 8

SELECT 
    veh_reg_no, vehicles.brand, vehicles.`desc`
FROM
    vehicles
        LEFT JOIN
    rental_records USING (veh_reg_no)
WHERE
    veh_reg_no NOT IN (SELECT 
            veh_reg_no
        FROM
            rental_records
        WHERE
            start_date <= '2012-01-10'
                AND end_date >= '2012-01-10');

-- QUESTION 9

SELECT 
    veh_reg_no, vehicles.brand, vehicles.`desc`
FROM
    vehicles
        LEFT JOIN
    rental_records USING (veh_reg_no)
WHERE
    veh_reg_no NOT IN (SELECT 
            veh_reg_no
        FROM
            rental_records
        WHERE
            (start_date >= '2012-01-03'
                AND start_date <= '2012-01-18')
                OR (end_date <= '2012-01-03'
                AND end_date <= '2012-01-18')
                OR (start_date <= '2012-01-03'
                AND end_date >= '2012-01-18'));

-- QUESTION10

SELECT 
    veh_reg_no, vehicles.brand, vehicles.`desc`
FROM
    vehicles
        LEFT JOIN
    rental_records USING (veh_reg_no)
WHERE
    veh_reg_no NOT IN (SELECT 
            veh_reg_no
        FROM
            rental_records
        WHERE
            (start_date > NOW()
                AND start_date < DATE_ADD(NOW(), INTERVAL 10 DAY))
                OR (start_date < NOW()
                AND end_date > DATE_ADD(NOW(), INTERVAL 10 DAY))
                OR (end_date < NOW()
                AND end_date < DATE_ADD(NOW(), INTERVAL 10 DAY)));