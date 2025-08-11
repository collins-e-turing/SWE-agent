#!/bin/bash
PIPELINE_ROOT="/home/collins/projects/meson-vuln-pipeline"

echo "Starting exploratory memory vulnerability trajectory generation..."
echo "Timestamp: $(date)"
echo "Configuration: swe-memory-config-exploratory.yaml"
echo "CVE: CVE-2024-47606 (Integer underflow in GStreamer qtdemux Theora extension)"
echo "Focus: Creative exploration of vulnerability reproduction and patch development"
echo ""

# Set environment variables for consistency
export PROJ_NAME="gstreamer"
export CVE_ID="CVE-2024-47606"
export PIPELINE_ROOT="$PIPELINE_ROOT"
export GEMINI_API_KEY="${GEMINI_API_KEY}"

# Generate exploratory trajectory using the problem statement
LOG_FILE="trajectories/exploratory_$(date +%Y%m%d_%H%M%S).log"

if python -m sweagent run \
    --config swe-memory-config-exploratory.yaml \
    --problem_statement.path="$PIPELINE_ROOT/projects/gstreamer/vulnerabilities/CVE-2024-47606/problem_statement.md" \
    2>&1 | tee "$LOG_FILE"; then
    echo ""
    echo "✅ SUCCESS: Exploratory memory vulnerability trajectory generation complete."
    echo "📄 Output saved to: $LOG_FILE"
    echo "📁 Trajectory files in: trajectories/ directory"
else
    echo ""
    echo "❌ FAILED: Exploratory memory vulnerability trajectory generation failed."
    echo "📄 Error log saved to: $LOG_FILE"
    echo "🔍 Check the log file for detailed error information."
    exit 1
fi
