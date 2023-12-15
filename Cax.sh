#!/bin/bash

# Membaca nilai dari berkas .env
if [ -f .env ]; then
  source .env
else
  echo "Error: .env file not found."
  exit 1
fi

# Menampilkan menu pilihan
echo "Pilihan tindakan:"
echo "1. Withdraw"
echo "2. Lihat Order Books"
echo "3. Lihat Order Books tanpa Pair Khusus"
read -p "Masukkan pilihan (1/2/3): " CHOICE

case "$CHOICE" in
  "1")
    # Meminta pengguna memilih symbol (ATN atau NTN)
    read -p "Pilih symbol (ATN atau NTN): " SYMBOL
    if [ "$SYMBOL" != "ATN" ] && [ "$SYMBOL" != "NTN" ]; then
      echo "Symbol tidak valid."
      exit 1
    fi

    # Meminta pengguna memilih pair (ATN-USD atau NTN-USD)
    read -p "Pilih pair (ATN-USD atau NTN-USD): " PAIR
    if [ "$PAIR" != "ATN-USD" ] && [ "$PAIR" != "NTN-USD" ]; then
      echo "Pair tidak valid."
      exit 1
    fi

    # Meminta pengguna memasukkan jumlah withdraw
    read -p "Masukkan jumlah withdraw: " AMOUNT

    # Menjalankan HTTP POST withdraws dengan symbol dan amount yang dipilih
    http POST "https://cax.piccadilly.autonity.org/api/withdraws/" "API-Key:$APIKEY" "symbol=$SYMBOL" "amount=$AMOUNT"
    ;;
  "2")
    # Menjalankan HTTP GET orderbooks dengan pair yang dipilih
    http GET "https://cax.piccadilly.autonity.org/api/orderbooks/$PAIR/quote" "API-Key:$APIKEY"
    ;;
  "3")
    # Menjalankan HTTP GET orderbooks tanpa pair khusus
    http GET "https://cax.piccadilly.autonity.org/api/orderbooks/" "API-Key:$APIKEY"
    ;;
  *)
    echo "Pilihan tidak valid."
    exit 1
    ;;
esac
