echo "run,total,result" > func_test_result.csv

for i in {1..30}; do
    echo "=== Run $i ==="
    start_time=$(date +%s%3N)

    pytest app/tests/test_api.py \
        --durations=0 \
        --durations-min=0 \
        > "pytest_run_$i.txt" 2>&1

    exit_code=$?

    end_time=$(date +%s%3N)
    total=$(python -c "print(round((float(end_time) - float(start_time)), 4))")

    if [ $exit_code -eq 0 ]; then
        result="PASS"
    else
        result="FAIL"
    fi

    echo "$i,$total,$result" >> func_test_result.csv

    cat "pytest_run_$i.txt"

done

