#!/bin/bash

commands=(
    "ls"
    "pwd"
    "echo 'Hello, World!'"
    "whoami"
)

run_test() {
    echo "🚀 Lancement des tests..."

    for cmd in "${commands[@]}"; do
        echo "$cmd" | ./mysh > output.txt
        echo "$cmd" | tcsh > expected_output.txt
        diff output.txt expected_output.txt
        if [ $? -eq 0 ]; then
            echo "✅ Test '$cmd' réussi"
        else
            echo "❌ Test '$cmd' échoué"
            echo "📌 Différences :"
            diff output.txt expected_output.txt
        fi
    done

    echo "🛠️ Tests terminés !"
}

main() {
    run_test
}

main "$@"
