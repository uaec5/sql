# Car Sales SQL Schema

This repository contains a single SQL script, **`create_car_sales_schema.sql`**, which creates and seeds a small sample database for a car‐sales scenario.

## Tables

| Table      | Purpose                                   |
|------------|-------------------------------------------|
| `customer` | Stores customer details                   |
| `Table_1`  | Stores car models (ID, name, model year)  |
| `sales`    | Records sales linking customers to cars   |

## How to Use

1. Open SQL Server Management Studio (or any T-SQL client).
2. Select / create the target database.
3. Execute the contents of `create_car_sales_schema.sql`.
   * The script is **idempotent**: it checks each table and sample row before inserting, so running it multiple times is safe.
4. Query the joined view at the end of the script to see sample output.

```sql
SELECT * FROM sales;             -- Quick look at sales
```

## Extending

- Add more `INSERT` statements following the chosen pattern.
- Modify datatypes / constraints to suit real-world requirements.

## License

MIT
