# peakperformance_shop

## Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Dalam Flutter, widget tree adalah struktur hierarki yang merepresentasikan semua tampilan (UI elements) pada aplikasi.
Setiap widget yang kita buat akan menjadi node dalam pohon (tree), di mana node bisa punya induk (parent) dan anak (child).
Setiap widget punya posisi dan fungsi tersendiri, tapi semuanya membentuk satu gambar utuh (UI aplikasi).

Cara kerja widget tree:
- Parent widget menentukan bagaimana child widget ditampilkan dan berperilaku.
- Ketika ada perubahan pada state atau properti, Flutter hanya akan membangun ulang bagian tree yang terpengaruh, bukan seluruh aplikasi, inilah yang membuat performanya menjadi lebih efisien.
- Tree ini digunakan saat proses layout (mengatur posisi), rendering (menggambar ke layar), dan hit testing (mendeteksi sentuhan).

## Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

## Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

## Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

## Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

## Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
