build_extra/duckdb:
	mkdir -p build_extra
	git clone https://github.com/duckdb/duckdb.git --single-branch --branch v1.3.0 build_extra/duckdb

build_extra/patch_files:
	find test/duckdb/patches/* -type f -name '*.patch' -print0 | xargs -0 cat | patch -p1 --forward -d build_extra/duckdb
	touch build_extra/patch_files

setup_duckdb_side_repo: build_extra/duckdb build_extra/patch_files

build_duckdb_side_repo: setup_duckdb_side_repo
	cd build_extra/duckdb && USE_MERGED_VCPKG_MANIFEST=1 VCPKG_TOOLCHAIN_PATH=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake CORE_EXTENSIONS="ducklake;${CORE_EXTENSIONS}" make
	echo "unittester will be available at build_extra/duckdb/build/release/test/unittester"
	echo "Consider running 'make run_all_tests_duckdb_side_repo'"

run_all_tests_duckdb_side_repo:
	./build_extra/duckdb/build/release/test/unittest

clean_duckdb_side_repo:
	cd build_extra/duckdb && make clean

clean_all_build_extra:
	rm -rf build_extra
