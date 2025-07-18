# Build POSTGRES Tool

A Docker-based build system for the postgresql

## Usage

### build_postgres

Builds postgres from source code at the specified path:

```bash
build_postgres <source_code_path>
```

**Arguments:**
- `source_code_path`: Path to the postgres source code directory

**Example:**
```bash
build_postgres /path/to/postgres/source
```

The tool will:
1. Validate the source path exists
2. Configure the build using Meson
3. Compile using Ninja with address sanitizer and debug symbols
4. Generate the postgres executable at `/build_output/tools/postgres`

### build_postgres_state

Returns the current build state in JSON format:

```bash
build_postgres_state
```

**Output:**
```json
{
  "executable_path": "/build_output/tools/postgres",
  "build_output_dir": "/build_output",
  "build_complete": true
}
```

**Fields:**
- `executable_path`: Path to the generated postgres executable (null if not built)
- `build_output_dir`: Directory containing build artifacts
- `build_complete`: Boolean indicating if the build completed successfully
