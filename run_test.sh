#!/bin/bash

echo "🚀 Lancement des tests..."

while read -r cmd; do
    echo " "
    echo "$cmd" | ../../mysh > output.txt
    echo "$cmd" | tcsh > expected_output.txt
    diff output.txt expected_output.txt
    if [ $? -eq 0 ]; then
        echo "✅ Test '$cmd' réussi"
    else
        echo " "
        echo "❌ Test '$cmd' échoué"
        echo "📌 Différences :"
        diff output.txt expected_output.txt
    fi
done < text_case.txt
echo "🛠️ Tests terminés !"