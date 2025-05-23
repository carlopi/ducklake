This is a way to re-use DuckDB tests to tests DuckLake as default database.
Most tests will not be supported (e.g. there is currently no primary key support in DuckLake) but the aim is exposing DuckLake to a wider test environment, already collected over time.

Basic usage is like:
```
# Clone, patch and build DuckDB with linked-in ducklake
make build_duckdb_side_repo

# Run a specific test
./build_extra/duckdb/build/release/test/unittest "

# Run a category of tests
./build_extra/duckdb/build/release/test/unittest "[topn]"

# Run all tests (equivalent to './build_extra/duckdb/build/release/test/unittest')
make run_all_tests_duckdb_side_repo
```
