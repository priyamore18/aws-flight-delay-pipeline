# AWS Flight Delay Data Engineering Project

## Lab 4: Athena — CSV vs Parquet

### Performance Comparison

| Table             | Format           | Data Scanned | Run Time |

| `raw_flights`     | CSV              | 23.53 MB     | 746 ms |
| `flights_parquet` | Parquet (Snappy) | 318.53 KB    | 607 ms |

### Key Findings

- **Data scanned:** Parquet scanned approximately 98.7% less data than CSV.
- **Query runtime:** Parquet completed in 607 ms, compared with 746 ms for CSV in these runs.
- **Why Parquet helps:** Parquet stores data by column and supports compression, allowing Athena to read less data when a query uses only selected columns.
- **Cost benefit:** Athena's scan-based query charges can be lower when less data is scanned.

### SQL Queries

All Lab 4 SQL queries are saved in [`sql/week1_queries.sql`](sql/week1_queries.sql).


## Lab 5: Partitioning and Lake Formation

### Partitioning
Created `flights_by_month` in Parquet format, partitioned by the `month` column. The current sample contains only January data, so only the `month=1/` partition was created.

### Partition Scan Comparison

| Table | Data scanned | Run time |
|---|---:|---:|
| `flights_by_month` | 250.12 KB | 807 ms |
| `flights_parquet` | 250.02 KB | 541 ms |

**Observation:** Both queries returned the same average departure delay. Scanned data was nearly identical because the current sample contains only one month, so partition pruning could not skip other months.

### Lake Formation
- **IAM:** Controls access to AWS services and resources.
- **AWS Lake Formation:** Adds fine-grained data lake permissions for databases, tables, columns, and, where configured, rows.
- **Observation:**  Inspected the Lake Formation data permissions list. Permissions vary by resource and can include actions such as Select or broader access. No settings were changed.