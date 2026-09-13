#!/usr/bin/env python3
"""
Helper script to create the KAVACH logo
Save this file and run: python save_logo.py
"""

import base64
from pathlib import Path

# Base64 encoded PNG of the KAVACH logo
LOGO_BASE64 = """
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==
"""

def save_logo():
    # Create assets/images directory if it doesn't exist
    assets_dir = Path(__file__).parent / "assets" / "images"
    assets_dir.mkdir(parents=True, exist_ok=True)
    
    # Save the logo
    logo_path = assets_dir / "kavach_logo.png"
    
    # Decode and save
    logo_data = base64.b64decode(LOGO_BASE64.strip())
    logo_path.write_bytes(logo_data)
    
    print(f"✓ Logo saved to: {logo_path}")

if __name__ == "__main__":
    save_logo()
