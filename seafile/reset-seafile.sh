#!/bin/zsh

# Este script borrará y redesplegará por completo la aplicación Seafile.
# ¡ADVERTENCIA! Todos los datos existentes se perderán.

# --- Configuración ---
NAMESPACE="seafile"

# --- Inicio del Script ---
echo "🔵 Iniciando el reseteo completo de Seafile en el namespace '$NAMESPACE'..."
echo "---------------------------------------------------------"

# --- 1. Fase de Borrado ---
echo "🔥 Borrando Deployments..."
kubectl delete deployment seafile -n $NAMESPACE
kubectl delete deployment mariadb-deployment -n $NAMESPACE

echo "🔥 Borrando PersistentVolumeClaims (¡SE PERDERÁN LOS DATOS!)..."
kubectl delete pvc seafile-data -n $NAMESPACE
kubectl delete pvc mariadb-data -n $NAMESPACE

echo "✅ Fase de borrado completada."
echo "---------------------------------------------------------"
sleep 2 # Pequeña pausa

# --- 2. Fase de Re-aplicación ---
echo "🚀 Aplicando almacenamiento y configuración..."
kubectl apply -f mariadb-conf.yaml
kubectl apply -f seafile-persistentvolumeclaim.yaml
kubectl apply -f seafile-env.yaml

echo "🚀 Desplegando la base de datos MariaDB..."
kubectl apply -f mariadb-deployment.yaml

echo "⏳ Esperando a que la base de datos MariaDB esté lista..."
# Este comando esperará automáticamente hasta 5 minutos a que el deployment esté listo
kubectl wait --for=condition=available --timeout=300s deployment/mariadb-deployment -n $NAMESPACE

echo "✅ Base de datos lista."
echo "🚀 Desplegando la aplicación Seafile..."
kubectl apply -f seafile-deployment.yaml
kubectl apply -f seafile-service.yaml

echo "⏳ Esperando a que Seafile esté listo..."
kubectl wait --for=condition=available --timeout=300s deployment/seafile -n $NAMESPACE

echo "---------------------------------------------------------"
echo "🎉 ¡Despliegue completado! Estado final de los pods:"
kubectl get pods -n $NAMESPACE
