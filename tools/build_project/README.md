# Build DAV1D Tool

A Docker-based build system for the dav1d AV1 decoder library.

## Usage

### build_dav1d

Builds dav1d from source code at the specified path:

```bash
build_dav1d <source_code_path>
```

**Arguments:**
- `source_code_path`: Path to the dav1d source code directory

**Example:**
```bash
build_dav1d /path/to/dav1d/source
```

The tool will:
1. Validate the source path exists
2. Configure the build using Meson
3. Compile using Ninja with address sanitizer and debug symbols
4. Generate the dav1d executable at `/build_output/tools/dav1d`

### build_dav1d_state

Returns the current build state in JSON format:

```bash
build_dav1d_state
```

**Output:**
```json
{
  "executable_path": "/build_output/tools/dav1d",
  "build_output_dir": "/build_output", 
  "build_complete": true
}
```

**Fields:**
- `executable_path`: Path to the generated dav1d executable (null if not built)
- `build_output_dir`: Directory containing build artifacts
- `build_complete`: Boolean indicating if the build completed successfully