# export GEMINI_API_KEY=123

python3.11 -m sweagent run-batch \
    --config swe-memory-config.yaml \
    --instances.type expert_file \
    --instances.path swe-memory-instances.yaml