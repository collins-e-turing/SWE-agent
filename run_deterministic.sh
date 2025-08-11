#!/bin/bash
# run_deterministic.sh - Generate deterministic memory vulnerability trajectories
set -e

PIPELINE_ROOT="/home/collins/projects/meson-vuln-pipeline"
cd "$PIPELINE_ROOT/SWE-agent-fork"

echo "Starting deterministic memory vulnerability trajectory generation..."
echo "Timestamp: $(date)"
echo "Configuration: swe-memory-config-deterministic.yaml"
echo "CVE: CVE-2024-47606 (Integer underflow in GStreamer qtdemux Theora extension)"
echo "Focus: Systematic exploitation of provided test case + patch application"
echo ""

# Set environment variables for consistency
export PROJ_NAME="gstreamer"
export CVE_ID="CVE-2024-47606"
export PIPELINE_ROOT="$PIPELINE_ROOT"
export GEMINI_API_KEY="${GEMINI_API_KEY}"

# Generate deterministic trajectory using the problem statement
LOG_FILE="trajectories/deterministic_$(date +%Y%m%d_%H%M%S).log"

# Run the command and capture exit code separately from output
python -m sweagent run \
    --config swe-memory-config-deterministic.yaml \
    --problem_statement.path="$PIPELINE_ROOT/projects/gstreamer/vulnerabilities/CVE-2024-47606/problem_statement.md" \
    2>&1 | tee "$LOG_FILE"

# Capture the exit code from the python command
EXIT_CODE=${PIPESTATUS[0]}

if [ $EXIT_CODE -eq 0 ]; then
    echo ""
    echo "✅ SUCCESS: Deterministic memory vulnerability trajectory generation complete."
    echo "📄 Output saved to: $LOG_FILE"
    echo "📁 Trajectory files in: trajectories/ directory"
else
    echo ""
    echo "❌ FAILED: Deterministic memory vulnerability trajectory generation failed."
    echo "📄 Error log saved to: $LOG_FILE"
    echo "🔍 Check the log file for detailed error information."
    echo "🚨 Exit code: $EXIT_CODE"
    exit 1
fi
