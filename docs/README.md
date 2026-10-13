# Lab 3: AWS Glue Data Catalog

- **Data Catalog:** Stores metadata about tables, including column names, data types, and S3 locations. It does not store the actual CSV data.
- **Crawler:** Scans files in S3, infers their schema, and creates or updates tables in the Data Catalog.
- **Classifier:** Helps the crawler recognize CSV structure, including delimiters, quote characters, and column headers.