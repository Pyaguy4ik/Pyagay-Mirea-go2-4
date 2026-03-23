#!/bin/bash

echo "=== Generating Load for Metrics ==="
echo ""

echo -n "GET /v1/tasks (200 OK): "
for i in {1..50}; do
    curl -s http://localhost:8082/v1/tasks > /dev/null
    echo -n "."
done
echo " 50 requests"

echo -n "GET /v1/tasks/error (500): "
for i in {1..20}; do
    curl -s http://localhost:8082/v1/tasks/error > /dev/null
    echo -n "."
done
echo " 20 requests"

echo -n "POST /v1/tasks (201 Created): "
for i in {1..30}; do
    curl -s -X POST http://localhost:8082/v1/tasks \
        -H "Content-Type: application/json" \
        -d '{"title":"Test Task","description":"Test Description","due_date":"2026-01-12"}' > /dev/null
    echo -n "."
done
echo " 30 requests"

echo ""
echo "=== Load Generation Complete ==="
echo ""
echo "Check metrics: curl -s http://localhost:8082/metrics | grep http_requests_total"
