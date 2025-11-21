# SEC-Filings dbt project

This repo contains a minimal dbt project to model SEC quarterly financials using the public BigQuery dataset.

## Quickstart

1. Install dbt (core) and the BigQuery adapter. Example using pip:

````markdown
```bash
python -m venv .venv
source .venv/bin/activate
pip install dbt-bigquery
```
````

2. Create a local dbt profiles.yml at ~/.dbt/profiles.yml with a profile named `sec_filings_profile` (example below). Do NOT commit your credentials to the repo.

Example profiles.yml (BigQuery):

```yaml
sec_filings_profile:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: oauth
      project: your-gcp-project-id
      dataset: your_dbt_dataset
      threads: 4
      timeout_seconds: 300
      location: US
```

3. Run dbt:

```bash
dbt debug
dbt run
dbt test
```

## Notes
- The Metrics model lives in models/metrics.sql and materializes as a view by default.
- Keep credentials out of source control. Use environment variables or a local profiles.yml.
