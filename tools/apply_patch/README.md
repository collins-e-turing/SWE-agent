# Apply Patch Tool

A tool to apply the given patch in the given source code location.

## ⚠️ Security Notice

This tool is designed for **defensive security research purposes only**. It should only be used in controlled environments for:
- Vulnerability research and analysis
- Security testing of patched systems
- Educational purposes in cybersecurity

## Vulnerability Details

- **CVE ID**: CVE-2024-1580
- **Type**: Use-after-free vulnerability
- **Component**: dav1d AV1 decoder film grain parameters
- **Impact**: Memory corruption leading to potential code execution

## Usage

### apply_patch

Applies the patch in the system on the given source code location

```bash
apply_patch <patch_path>
```

**Arguments:**
- `patch_path`: Path to the patch file to apply


**Example:** (TODO: edit rest of the readme file for patching logic)
```bash
apply_patch patch_path
```

The tool will:
1. Validate the dav1d binary exists and is executable
2. Generate a specially crafted AV1 file that triggers the vulnerability
3. Execute the dav1d binary with the malformed input
4. Monitor for crashes or ASAN reports indicating the vulnerability was triggered

**Return Codes:**
- `0`: Vulnerability successfully triggered (crash detected)
- `1`: Vulnerability not triggered or test failed

### trigger_vulnerability_state

Returns the current vulnerability test state in JSON format:

```bash
trigger_vulnerability_state
```

**Output:**
```json
{
  "last_trigger_result": 0,
  "last_trigger_success": true,
  "last_binary_path": "/build_output/tools/dav1d",
  "last_trigger_timestamp": "2024-06-24T10:30:45Z",
  "vulnerability_id": "CVE-2024-1580",
  "vulnerability_description": "use-after-free vulnerability in dav1d film grain parameters"
}
```

**Fields:**
- `last_trigger_result`: Exit code from last trigger attempt (null if never run)
- `last_trigger_success`: Boolean indicating if vulnerability was triggered successfully
- `last_binary_path`: Path to the last tested dav1d binary
- `last_trigger_timestamp`: ISO timestamp of last trigger attempt
- `vulnerability_id`: CVE identifier being tested
- `vulnerability_description`: Brief description of the vulnerability

## Technical Details

The vulnerability trigger works by:

1. Creating a malformed AV1 bitstream with specific film grain parameters
2. The payload consists of:
   - Initial chunk with crafted header data
   - 511 chunks of padded data
   - Final chunk of zero bytes
3. When processed by vulnerable dav1d versions, this causes a use-after-free condition in the film grain parameter handling

## Safety Considerations

- Only use in isolated test environments
- Ensure proper memory safety tools (ASAN, Valgrind) are available for detection
- Do not use on production systems
- The tool creates temporary files that are cleaned up automatically