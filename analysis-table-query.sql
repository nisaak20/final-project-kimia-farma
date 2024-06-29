-- Creating a New Table
CREATE TABLE kimia_farma.tabel_analisis AS
-- Selecting Columns for a New Table
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
    -- Calculating Gross Profit Percentage Based on Price
    CASE
        WHEN c.price <= 50000 THEN 0.10 
        WHEN c.price BETWEEN 50000 AND 100000 THEN 0.15
        WHEN c.price BETWEEN 100000 AND 300000 THEN 0.20
        WHEN c.price BETWEEN 300000 AND 500000 THEN 0.25
        WHEN c.price > 500000 THEN 0.30
    END AS percentage_gross_laba, 
    -- Calculating Nett Sales
    c.price - (c.price * c.discount_percentage) AS nett_sales,
    -- Calculating Nett Profit
    ( c.price * (CASE
        WHEN c.price <= 50000 THEN 0.10 
        WHEN c.price BETWEEN 50000 AND 100000 THEN 0.15
        WHEN c.price BETWEEN 100000 AND 300000 THEN 0.20
        WHEN c.price BETWEEN 300000 AND 500000 THEN 0.25
        WHEN c.price > 500000 THEN 0.30
    END))-(c.price - (c.price - (c.price * c.discount_percentage)) ) AS nett_profit,
    c.rating AS rating_transaksi
FROM 
    kimia_farma.kf_final_transaction AS c
-- Menggabungkan kf_final_transaction, kf_kantor_cabang, dan kf_inventory berdasarkan branch_id dan product_id
INNER JOIN 
    kimia_farma.kf_kantor_cabang AS b ON c.branch_id = b.branch_id
INNER JOIN 
    kimia_farma.kf_inventory AS a ON c.product_id = a.product_id AND b.branch_id = a.branch_id
;
