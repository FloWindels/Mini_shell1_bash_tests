#!/bin/bash

echo "🚀 Lancement des tests..."

while read -r cmd; do
    echo " "
    echo "$cmd" | ../../mysh > output.txt
    if [ $? -ne 0 ]; then
        echo "❌ Votre shell a planté en exécutant '$cmd'"
        continue
    fi
    echo "$cmd" | tcsh > expected_output.txt
    diff_output=$(diff output.txt expected_output.txt)
    if [ $? -eq 0 ]; then
        echo "✅ Test '$cmd' réussi"
    else
        echo " "
        echo "❌ Test '$cmd' échoué"
        echo "📌 Différences :"
        echo "$diff_output"
    fi
done < test_case.txt
echo "🛠️ Tests terminés !"