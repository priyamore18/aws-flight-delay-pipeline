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