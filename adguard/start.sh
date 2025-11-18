#!/bin/bash


# --- CONFIGURACIÓN ---

echo "🚀 Iniciando la aplicación de archivos YAML "
echo "--------------------------------------------------------"

# Comando principal: Encuentra todos los archivos con extensión .yaml o .yml y los aplica
# El comando 'find' localiza los archivos.
# 'sort' los ordena para asegurar que los deployments se apliquen después de los namespaces.
# 'xargs' pasa la lista de archivos a 'kubectl apply -f'.
find "$YAML_DIR" -type f \( -name "*.yaml" -o -name "*.yml" \) | sort | xargs kubectl apply -f

# Captura el código de salida del comando kubectl
EXIT_CODE=$?

# Reporte final
echo "--------------------------------------------------------"
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Éxito: Todos los archivos YAML fueron aplicados correctamente."
else
    echo "⚠️ Advertencia: Ocurrieron errores durante la aplicación de los archivos YAML. Revisa la salida anterior."
fi
