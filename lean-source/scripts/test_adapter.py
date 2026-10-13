"""Exercise the real NightAudit JSON interface using the existing protocol anchors."""
from pathlib import Path
import json
import struct
import subprocess

binary = Path('.lake/build/bin/nightaudit').resolve()
anchors = [
    ('Tortoise', [0.2, 0.8], 0.6),
    ('Cat', [0.8, 0.2], 0.6),
    ('Crocodile', [0.8, 0.2, 0.4], 0.7),
    ('Falcon', [40, 10, 5], 25),
    ('Phoenix', [1, 1, 1], 1),
    ('Bonobo', [0.2, 0.8], 0.6),
]
for animal, row, expected in anchors:
    result = subprocess.run([str(binary), animal], input=json.dumps([row])+'\n', text=True, capture_output=True, check=True, timeout=30)
    lines = result.stdout.splitlines()
    assert len(lines) == 1, (animal, result.stdout)
    actual = struct.unpack('<d', int(lines[0]).to_bytes(8, 'little'))[0]
    assert abs(actual-expected) < 1e-12, (animal, actual, expected)
    print(animal, 'adapter anchor passed')
