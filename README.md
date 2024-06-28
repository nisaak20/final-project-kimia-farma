# final-project-kimia-farma
CREATE TABLE kimia_farma.tabel_analisis AS
SELECT 
    c.transaction_id,
    c.date,
    b.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    b.rating AS rating_cabang,
    c.customer_name,
    c.product_id,
    a.product_name,
    c.price AS actual_price,
    c.discount_percentage, 
    CASE
        WHEN c.price <= 50000 THEN 0.10 
        WHEN c.price BETWEEN 50000 AND 100000 THEN 0.15
        WHEN c.price BETWEEN 100000 AND 300000 THEN 0.20
        WHEN c.price BETWEEN 300000 AND 500000 THEN 0.25
        WHEN c.price > 500000 THEN 0.30
    END AS percentage_gross_laba, 
    c.price - (c.price * c.discount_percentage) AS nett_sales,
    c.price * (CASE
        WHEN c.price <= 50000 THEN 0.10 
        WHEN c.price BETWEEN 50000 AND 100000 THEN 0.15
        WHEN c.price BETWEEN 100000 AND 300000 THEN 0.20
        WHEN c.price BETWEEN 300000 AND 500000 THEN 0.25
        WHEN c.price > 500000 THEN 0.30
    END) AS nett_profit,
    c.rating AS rating_transaksi
FROM 
    `kimia_farma.kf_final_transaction` AS c
LEFT JOIN 
    `kimia_farma.kf_kantor_cabang` AS b ON c.branch_id = b.branch_id
LEFT JOIN 
    `kimia_farma.kf_inventory` AS a ON c.product_id = a.product_id AND b.branch_id = a.branch_id
;

