# AWS Flight Delay Data Engineering Project

## What This Project Does

This project builds a small AWS data engineering pipeline for flight delay data using Amazon S3, AWS Glue, and Amazon Athena. It explores CSV ingestion, metadata discovery, SQL analysis, and conversion to compressed, partitioned Parquet datasets.

## Architecture

![AWS Flight Delay Pipeline Architecture](docs/architecture.png)

## S3 Layout

| S3 path | Purpose |
|---|---|
| `raw/flights/` | Original sample flight CSV |
| `raw/airlines/` | Airline reference CSV |
| `raw/airports/` | Airport reference CSV |
| `curated/flights_parquet/` | Parquet version of the flight dataset |
| `curated/flights_by_month/` | Parquet data partitioned by month |
| `athena-results/` | Athena query output files |

## Security

An IAM policy named `de-project-s3-access` grants the required S3 object actions and bucket-listing permissions for the project bucket. The `GlueServiceRole-de` role allows AWS Glue to assume the role and access the resources permitted by its attached policies.

The policy is scoped to the project bucket rather than all S3 buckets, following the principle of least privilege.

## Results

### Lab 4: Athena — CSV vs Parquet

| Table | Format | Data scanned | Run time |
|---|---|---:|---:|
| `raw_flights` | CSV | 23.53 MB | 746 ms |
| `flights_parquet` | Parquet (Snappy) | 318.53 KB | 607 ms |

**Key findings**

- Parquet scanned approximately 98.7% less data than CSV.
- Parquet completed in 607 ms, compared with 746 ms for CSV in these runs.
- Columnar storage and compression help Athena read less data when queries use selected columns.

### Lab 5: Partitioning

| Table | Data scanned | Run time |
|---|---:|---:|
| `flights_by_month` | 250.12 KB | 807 ms |
| `flights_parquet` | 250.02 KB | 541 ms |

**Observation:** Both queries returned the same average departure delay. Scanned data was nearly identical because the sample contains only January data, so partition pruning could not skip other months.

### Lake Formation

- **IAM:** Controls access to AWS services and resources.
- **AWS Lake Formation:** Adds fine-grained data lake permissions for databases, tables, columns, and configured row filters.
- **Observation:** Inspected the Lake Formation data permissions list without changing settings. Governance was shown as disabled for `raw_flights`.

## What I Learned

- How to store raw data in S3 and discover table schemas with AWS Glue Crawlers and the Data Catalog.
- How to query CSV data with Athena and convert it into compressed Parquet using CTAS.
- How partitioning can reduce scanned data when queries filter across multiple partition values, and how Lake Formation supports data lake governance.

## SQL Queries

All Lab 4 and Lab 5 queries are saved in [`sql/week1_queries.sql`](sql/week1_queries.sql).

## How to Run It

1. Upload the CSV datasets to the appropriate `raw/` S3 folders.
2. Run the Glue crawler to create or update tables in `flights_db`.
3. Configure Athena's query result location under `athena-results/`.
4. Run the SQL queries in `sql/week1_queries.sql`.
5. Create and query the Parquet tables under `curated/`.
6. Review the scan metrics, partition results, and AWS billing dashboard.