# peakperformance_shop

# Tugas Individu 7

## 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Dalam Flutter, widget tree merupakan struktur hierarki yang merepresentasikan seluruh elemen tampilan (UI elements) aplikasi dari bagian paling atas hingga paling bawah. Setiap widget yang dibuat akan menjadi node dalam pohon (tree), di mana setiap node dapat memiliki induk (parent) maupun anak (child). Artinya, setiap kali terdapat widget di dalam widget lain, maka secara otomatis terbentuk hubungan parent–child di antara keduanya. Flutter akan melakukan rebuild hanya pada bagian tree yang mengalami perubahan data atau state, bukan pada keseluruhan tampilan aplikasi. Setiap widget memiliki posisi dan perannya masing-masing, namun seluruhnya saling terhubung membentuk satu kesatuan antarmuka pengguna (user interface) yang utuh dan dinamis.

Cara kerja widget tree:
- Parent widget menentukan bagaimana child widget ditampilkan dan berperilaku.
- Ketika ada perubahan pada state atau properti, Flutter hanya akan membangun ulang bagian tree yang terpengaruh, bukan seluruh aplikasi, inilah yang membuat performanya menjadi lebih efisien.
- Tree ini digunakan saat proses layout (mengatur posisi), rendering (menggambar ke layar), dan hit testing (mendeteksi sentuhan).

## 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
runApp() untuk menjalankan aplikasi dan memanggil widget utama (MyApp).
MyApp (StatelessWidget) menjadi root aplikasi, membungkus seluruh UI dalam MaterialApp.
ThemeData untuk menentukan tema warna aplikasi (primarySwatch, accentColor).
Scaffold untu menyediakan struktur halaman standar dengan AppBar, body, dsb.
AppBar untuk menampilkan agian paling atas pada aplikasi dengan judul “Peak Performance Shop”.
Text untuk menampilkan teks (judul, nama, NPM, kelas, dll).
Padding untuk memberi jarak di sekitar konten agar tidak menempel ke tepi layar.
Column untuk menyusun elemen secara vertikal (misal: Row, Text, GridView).
Row untuk menyusun InfoCard secara horizontal (NPM, Name, Class).
InfoCard (custom StatelessWidget) sebagai kartu kecil berisi label dan isi data.
Card untuk membungkus InfoCard dengan tampilan seperti kartu. Card juga embuat tampilan kartu dengan efek bayangan (elevation).
SizedBox untuk menambahkan jarak vertikal antar elemen.
Center untuk menempatkan isi di tengah halaman.
GridView.count untuk menampilkan daftar ItemCard dalam bentuk grid 3 kolom.
Container untuk menentukan ukuran, padding, dan isi pada setiap kartu.
ItemCard (custom StatelessWidget) sebagai kartu berwarna dengan ikon dan teks yang bisa ditekan.
Material untuk memberi efek ink ripple dan warna latar pada ItemCard.
InkWell untuk menangani interaksi sentuh (klik/tap) pada kartu/card.
Icon untuk menampilkan ikon sesuai item (store, folder, add_box), mirip emoticon gitu.
SnackBar untuk menampilkan pesan kecil di bawah layar saat itemnya ditekan.
ScaffoldMessenger untuk mengatur tampilan SnackBar pada halaman aktif.

Semua widget ini digabung dalam satu widget tree besar dari atas (MyApp) sampai ke paling dalam (Icon dan Text di dalam ItemCard).

## 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
Widget MaterialApp berfungsi sebagai inti dari aplikasi Flutter yang menerapkan kerangka Material Design. Widget ini mengatur berbagai konfigurasi penting yang digunakan secara global dalam aplikasi, seperti judul aplikasi melalui properti title, tema warna dan gaya menggunakan theme, serta navigasi antar halaman dengan properti home, routes, dan Navigator. Selain itu, MaterialApp juga menyediakan akses konteks tema (BuildContext) yang memungkinkan widget lain di bawahnya untuk menggunakan warna, font, dan gaya yang konsisten sesuai dengan tema utama.
Implementasi MaterialApp pada kode saya:
return MaterialApp(
    title: 'Peak Performance Shop',
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.pinkAccent[400]),
    ),
    home: MyHomePage(),
);
Dari kode tersebut, MaterialApp berfungsi mengatur judul aplikasi “Peak Performance Shop”, menerapkan tema utama berwarna pink, dan menetapkan MyHomePage sebagai halaman utama aplikasi. Karena MaterialApp menjadi pusat konfigurasi global, widget ini umumnya ditempatkan sebagai root widget, sehingga semua widget di bawahnya dapat “mewarisi” tema, warna, serta pengaturan navigasi yang sama.

## 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
Dalam Flutter, terdapat dua jenis widget utama, yaitu StatelessWidget dan StatefulWidget. Perbedaan utamanya terletak pada kemampuan keduanya dalam menangani perubahan data (state). StatelessWidget bersifat statis, artinya data dan tampilannya tidak akan berubah selama aplikasi berjalan. Setelah dibangun, widget jenis ini hanya akan diperbarui apabila terjadi perubahan dari parent widget-nya. Pada proyek saya, contoh penerapan StatelessWidget terdapat pada MyApp, MyHomePage, InfoCard, dan ItemCard, karena seluruhnya menampilkan data tetap seperti teks dan ikon tanpa interaksi atau perubahan nilai.

Sementara itu, StatefulWidget bersifat dinamis dan dapat berubah sesuai dengan interaksi pengguna maupun logika aplikasi. Widget ini memiliki objek State yang menyimpan data yang dapat dimodifikasi. Ketika terjadi perubahan data, metode setState() dipanggil untuk memperbarui tampilan sesuai kondisi terbaru tanpa perlu membangun ulang seluruh aplikasi. Jenis widget ini umumnya digunakan pada komponen yang interaktif, seperti counter, form input, atau tampilan yang memerlukan pembaruan secara real-time.

Dengan demikian, StatelessWidget digunakan ketika tampilan aplikasi bersifat tetap dan tidak bergantung pada perubahan data, sedangkan StatefulWidget digunakan ketika tampilan perlu beradaptasi terhadap perubahan nilai atau aksi dari pengguna.

## 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext merupakan objek yang merepresentasikan posisi suatu widget di dalam widget tree pada aplikasi Flutter. Objek ini berperan penting karena menyediakan konteks yang memungkinkan sebuah widget untuk berinteraksi atau mengakses widget lain yang berada di atasnya dalam hierarki tree. Melalui BuildContext, sebuah widget dapat mengambil informasi atau properti yang telah didefinisikan sebelumnya, seperti tema warna dan gaya aplikasi menggunakan Theme.of(context), atau menampilkan notifikasi sementara (SnackBar) dengan ScaffoldMessenger.of(context). Objek ini juga digunakan di dalam metode build(BuildContext context) untuk menentukan bagaimana sebuah widget akan ditampilkan berdasarkan posisinya dalam struktur aplikasi.

Pada kode saya, contoh penggunaan BuildContext dapat dilihat pada bagian:
backgroundColor: Theme.of(context).colorScheme.primary,

Baris tersebut menunjukkan bahwa BuildContext digunakan untuk mengakses warna utama dari tema yang telah ditetapkan di MaterialApp. Dengan kata lain, BuildContext dapat diibaratkan seperti “alamat” dari suatu widget dalam pohon aplikasi, yang memungkinkan widget tersebut mengetahui lokasi dirinya sekaligus mengakses data, tema, atau fungsi dari widget lain yang berada di tingkat lebih atas.

## 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Dalam Flutter, terdapat dua fitur penting yang sangat membantu proses pengembangan aplikasi, yaitu Hot Reload dan Hot Restart. Keduanya berfungsi untuk mempercepat proses uji coba perubahan kode, namun memiliki perbedaan dalam mekanisme dan dampaknya terhadap aplikasi. Hot Reload bekerja dengan cara menyuntikkan perubahan kode langsung ke dalam aplikasi yang sedang berjalan tanpa menghentikan prosesnya. Dengan demikian, perubahan pada tampilan seperti warna, tata letak, atau teks dapat langsung terlihat di emulator atau perangkat tanpa kehilangan keadaan (state) aplikasi.

Sementara itu, Hot Restart menjalankan ulang seluruh aplikasi dari awal dengan mengeksekusi kembali fungsi main(). Akibatnya, semua data dan state yang sebelumnya tersimpan akan hilang dan aplikasi akan kembali ke kondisi awal. Proses ini umumnya membutuhkan waktu sedikit lebih lama dibandingkan hot reload karena seluruh inisialisasi dilakukan kembali.

Pada komentar kode di proyek saya juga dijelaskan perbedaannya secara eksplisit: “Notice that the counter didn’t reset back to zero; the application state is not lost during the reload. To reset the state, use hot restart instead.” Dari situ dapat disimpulkan bahwa Hot Reload lebih cocok digunakan saat melakukan perubahan tampilan atau logika kecil pada UI, sedangkan Hot Restart digunakan ketika ada perubahan besar pada variabel global atau inisialisasi awal yang memerlukan pengulangan penuh dari aplikasi.

