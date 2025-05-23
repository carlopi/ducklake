This is a way to re-use DuckDB tests to tests DuckLake as default database.
Most tests will not be supported (e.g. there is currently no primary key support in DuckLake) but the aim is exposing DuckLake to a wider test environment, already collected over time.

Build DuckDB (with statically linked ducklake)
---

```
# Clone, patch and build DuckDB with linked-in ducklake
make build_duckdb_side_repo
```
Build step can take other option via env variables:
```
GEN=ninja
CORE_EXTENSIONS=httpfs
VCPKG_ROOT=/path/to/vcpkg
```

A more complex example would be:
```
GEN=ninja CORE_EXTENSIONS="tpch;httpfs" make build_duckdb_side_repo
```


Run Tests
---
```
# Run a specific test
./build_extra/duckdb/build/release/test/unittest test/sql/join/inner/test_join_with_nulls.test_slow

# Run a category of tests
./build_extra/duckdb/build/release/test/unittest "[topn]"

# Run a glob of tests
./build_extra/duckdb/build/release/test/unittest "*join*"

# Run all tests (equivalent to './build_extra/duckdb/build/release/test/unittest')
make run_all_tests_duckdb_side_repo
```
Test step can, also via environemnt variable, take options like:

### DUCKLAKE_METADATA_DB
Current tested values "", "duckdb", "sqlite"
```
DUCKLAKE_METADATA_DB=sqlite ./build_extra/duckdb/build/release/test/unittest "[topn]"
```

### DUCKLAKE_S3_BUCKET_NAME
Bucket needs to exist and you need to have the correct privileges (possibly via creating the relevant persistent DuckDB secret)
```
DUCKLAKE_S3_BUCKET_NAME=my_bucket ./build_extra/duckdb/build/release/test/unittest "[topn]"
```

NOTE: this means data will be sent to the actual S3 bucket, and read over the wire. Do this with care.
