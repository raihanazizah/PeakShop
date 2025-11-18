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


# Tugas individu 8

## 1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Dalam Flutter, Navigator.push() dan Navigator.pushReplacement() memiliki peran penting dalam sistem navigasi berbasis tumpukan (stack). Perbedaan utama antara keduanya terletak pada cara mereka mengelola halaman sebelumnya. Metode Navigator.push() digunakan untuk menambahkan halaman baru di atas halaman yang sedang aktif tanpa menghapus halaman sebelumnya dari tumpukan. Hal ini memungkinkan pengguna untuk kembali ke halaman sebelumnya menggunakan tombol Back. Dalam konteks aplikasi Peak Performance Shop, metode ini digunakan ketika pengguna memilih salah satu tombol pada halaman utama seperti "Create Product" atau "All Products" di berkas product_card.dart. Misalnya, ketika pengguna menekan tombol Create Product, aplikasi berpindah ke halaman AddProductPage menggunakan Navigator.push() agar pengguna dapat kembali ke halaman utama setelah selesai menambahkan produk. Sebaliknya, Navigator.pushReplacement() digunakan untuk menggantikan halaman saat ini dengan halaman baru, menghapus halaman sebelumnya dari tumpukan navigasi. Metode ini digunakan pada komponen LeftDrawer ketika pengguna memilih menu navigasi seperti Home atau Add Products, karena setelah halaman tersebut dibuka, halaman sebelumnya tidak lagi diperlukan untuk kembali. Dengan demikian, Navigator.push() cocok untuk navigasi sementara yang memungkinkan kembali ke halaman sebelumnya, sedangkan Navigator.pushReplacement() ideal untuk transisi permanen antarhalaman utama aplikasi.

## 2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Struktur hierarki widget pada Flutter berperan penting dalam menciptakan tata letak yang konsisten dan terorganisir di seluruh halaman aplikasi. Dalam aplikasi Peak Performance Shop, widget Scaffold digunakan sebagai kerangka utama setiap halaman untuk menyediakan struktur yang lengkap, termasuk AppBar, Drawer, dan Body. Widget AppBar berfungsi menampilkan judul halaman serta memberikan identitas visual aplikasi melalui warna khas soft pink yang menjadi ciri khasnya. Contohnya terlihat pada halaman menu.dart, di mana AppBar menampilkan teks "Peak Performance Shop" dengan warna latar Colors.pink yang selaras dengan tema aplikasi. Selanjutnya, Drawer berfungsi sebagai menu navigasi samping yang memudahkan pengguna berpindah antarhalaman seperti Home, Add Products, dan Lihat Produk. Implementasinya terdapat pada berkas left_drawer.dart, yang menampilkan elemen-elemen menu dengan ikon dan judul yang jelas serta gaya visual seragam. Dengan kombinasi Scaffold, AppBar, dan Drawer, setiap halaman dalam aplikasi memiliki struktur dan navigasi yang konsisten, meningkatkan profesionalitas tampilan dan pengalaman pengguna.

## 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
Dalam pengembangan antarmuka berbasis form, penggunaan widget tata letak seperti Padding, SingleChildScrollView, dan ListView memberikan keuntungan besar dalam hal kenyamanan visual dan responsivitas tampilan. Widget Padding digunakan untuk memberikan jarak antar elemen sehingga form tidak terlihat padat, seperti pada berkas product_form.dart, di mana setiap TextFormField dan DropdownButtonFormField diberi jarak menggunakan SizedBox(height: 12) dan EdgeInsets.all(16.0). Hal ini membuat tampilan form menjadi rapi dan mudah dibaca. Sementara itu, SingleChildScrollView memungkinkan seluruh isi form dapat digulir (scroll) ketika tampil pada perangkat dengan ukuran layar kecil, mencegah terjadinya overflow. Penggunaannya terlihat pada bagian body di AddProductPage, yang membungkus seluruh isi form agar tetap dapat diakses meskipun kontennya panjang. Selain itu, ListView digunakan untuk menampilkan daftar produk pada halaman ViewProductPage. Dengan menggunakan ListView.builder(), daftar produk seperti “Sepatu Bola Nike” dan “Bola Adidas” dapat ditampilkan secara efisien dan dapat digulir dengan mulus. Kombinasi ketiga widget tersebut memastikan bahwa baik form maupun daftar produk tampil secara terstruktur, estetis, dan tetap responsif di berbagai ukuran layar.

## 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Dalam aplikasi Peak Performance Shop, penyesuaian warna tema dilakukan agar mencerminkan karakter merek yang sporty namun tetap elegan dengan dominasi warna soft pink. Implementasinya dapat dilihat pada berkas main.dart, di mana theme aplikasi diatur menggunakan ThemeData dengan primarySwatch bernuansa pink dan accent color Colors.pinkAccent[400]. Warna ini digunakan secara konsisten pada berbagai elemen antarmuka seperti AppBar, tombol, dan DrawerHeader, memberikan kesan harmonis yang kuat. Pendekatan ini selaras dengan prinsip desain brand consistency, di mana setiap elemen visual harus mendukung citra toko sebagai penyedia perlengkapan olahraga yang modern dan berenergi. Penggunaan warna soft pink memberikan kesan hangat dan inklusif, sementara aksen abu-abu atau warna gelap pada teks menambah sentuhan sporty dan profesional. Kombinasi warna tersebut menjadikan antarmuka aplikasi tidak hanya menarik secara estetika, tetapi juga mudah dikenali sebagai bagian dari identitas visual Peak Performance Shop.


# Tugas individu 9

## Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
Penggunaan model Dart seperti class ProductEntry memberi batasan tipe yang tegas antara data dan UI. Setiap atribut memiliki tipe yang pasti. Proses konversi tanggal atau angka berlangsung di satu lokasi. Validasi dan transformasi seperti mengubah string menjadi int dapat ditangani secara terstruktur.
Jika seluruh data disimpan dalam Map<String, dynamic> tanpa model, kemungkinan munculnya kesalahan meningkat. Kompilasi tidak dapat memeriksa tipe sehingga gangguan saat runtime lebih mudah terjadi, misalnya nilai null yang tidak terduga atau perubahan nama field. Pengelolaan null-safety menjadi lebih berat karena setiap akses perlu diperiksa secara manual. Perawatan kode juga lebih sulit karena banyak bagian aplikasi harus memahami format map yang sama. Perubahan pada API sering mengharuskan pembaruan di banyak bagian kode.
Model membantu penulisan unit test dan juga membuat struktur kode lebih mudah dijelaskan. Fitur autocompletion di IDE juga bekerja lebih baik sehingga proses pengembangan lebih tertata.

## Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
Package http bekerja sebagai klien HTTP umum. Fungsi get atau post dapat dipakai tanpa dukungan penyimpanan sesi otomatis.
CookieRequest dari pbp_django_auth memakai dasar HTTP yang sama tetapi sudah menyertakan pengelolaan sesi untuk Django. Cookie sessionid akan tersimpan dan terkirim kembali. CSRF token ikut diatur sesuai kebutuhan Django. Fitur seperti login, logout, postJson atau post sudah terhubung dengan penyimpanan cookie sehingga proses autentikasi lebih tertata.
Jadi, http cocok untuk permintaan yang tidak membutuhkan sesi. CookieRequest dipakai ketika aplikasi perlu autentikasi berbasis sesi dan butuh pengelolaan state secara otomatis.

## Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Satu instance CookieRequest perlu dipakai bersama karena data sesi seperti cookie, CSRF token, dan status login adalah bagian dari keadaan aplikasi yang dipakai di banyak halaman. Jika saya bagikan satu instance melalui Provider atau inherited widget, setiap komponen bisa membaca status login yang benar, mengirim request dengan cookie yang tepat, dan menangkap perubahan state tanpa harus menyalin atau menyinkronkan apa pun secara manual.
Dengan cara ini, tidak ada banyak versi data sesi yang berbeda. Proses pengecekan dan pemanggilan request lebih rapi. Django juga selalu menerima cookie yang sama sehingga pengguna dikenali dengan benar sepanjang penggunaan aplikasi.

## Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Agar emulator atau perangkat dapat mengakses server Django di mesin pengembang, beberapa pengaturan perlu disiapkan. Android emulator memakai alamat 10.0.2.2 untuk mengarah ke localhost host. Jika memakai alamat lain, koneksi ke server lokal tidak akan tercapai.
ALLOWED_HOSTS pada Django harus memuat host yang digunakan seperti localhost atau 10.0.2.2. Tanpa itu, Django akan menolak permintaan karena aturan keamanan. CORS perlu diaktifkan saat Flutter web atau permintaan lintas origin terlibat. Browser akan menahan response jika CORS tidak diatur. Untuk aplikasi mobile pembatasan tidak seketat browser. Namun pengaturan server tetap perlu agar response tidak terblokir.
Pengaturan cookie seperti SameSite dan Secure menentukan apakah cookie sesi ikut terkirim. SameSite yang terlalu ketat atau Secure tanpa HTTPS dapat membuat cookie tidak tersertakan. Django juga bisa meminta CSRF token untuk POST. Hal ini harus ditangani oleh CookieRequest agar permintaan tidak gagal.
Android membutuhkan permission INTERNET di AndroidManifest.xml. Tanpa izin ini koneksi jaringan tidak dapat dilakukan sehingga semua request akan gagal.
Jika konfigurasi tersebut tidak tepat, masalah yang muncul bisa berupa koneksi yang selalu gagal, cookie sesi yang tidak terkirim sehingga request.user terbaca sebagai Anonymous, atau permintaan yang diblokir oleh aturan CORS dan mekanisme keamanan server.

## Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Prosesnya berjalan seperti ini, pertama, pengguna mengisi form di layar. Setelah itu, data yang masuk diperiksa dulu di sisi aplikasi (misalnya apakah formatnya benar, panjangnya sesuai, atau URL valid). Setelah lolos pengecekan, data dikemas menjadi body request dalam bentuk form-encoded atau JSON. Permintaan (request) kemudian dikirim ke endpoint Django seperti POST create-product-flutter dengan menyertakan cookie sesi atau CSRF jika diperlukan.
Di sisi server, Django menerima permintaan tersebut di view. Isi request diperiksa ulang. Jika valid, data disimpan ke database melalui model. Server lalu mengirim response dalam bentuk JSON yang berisi informasi status atau data yang baru dibuat.
Flutter menerima response itu. JSON diubah menjadi model Dart seperti ProductEntry.fromJson. State aplikasi diperbarui melalui setState atau state manager. UI kemudian melakukan rebuild dan menampilkan data yang sudah diperbarui.
Setiap tahap membutuhkan validasi dan penanganan error agar alur tetap konsisten dan pengguna memperoleh pengalaman yang lancar.

## Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Proses dimulai dari register. Flutter mengirim data seperti username, password1, dan password2 ke endpoint Django. Server melakukan pengecekan. Jika valid, akun baru dibuat dan server mengirim status berhasil atau gagal.
Pada tahap login, Flutter memanggil request.login dengan alamat endpoint dan kredensial. Django memverifikasi data tersebut. Jika cocok, Django menjalankan login(request, user) lalu mengirim cookie sesi seperti sessionid dan kadang juga CSRF token. CookieRequest menyimpan cookie ini sehingga permintaan selanjutnya selalu membawa cookie yang sama.
Setelah login berhasil, state aplikasi diperbarui. Bagian UI yang membutuhkan autentikasi dapat muncul. Menu yang hanya boleh diakses pengguna terotentikasi juga dapat ditampilkan.
Untuk logout, Flutter memanggil endpoint logout atau request.logout. Django menghapus sesi di server. CookieRequest membersihkan cookie di sisi aplikasi. UI kemudian diperbarui, misalnya kembali ke halaman login atau menyembunyikan menu khusus pengguna.
Jadi intinya, session cookie menjadi bukti autentikasi. Selama cookie masih valid dan terkirim pada setiap permintaan, Django tetap mengenali identitas pengguna.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
Pertama, saya memastikan bahwa proyek Django telah berhasil dideploy dengan baik, termasuk menjalankan migrasi, memastikan model dapat diakses melalui admin, serta memverifikasi bahwa endpoint JSON menampilkan data sesuai struktur yang dibutuhkan oleh aplikasi Flutter. Setelah backend stabil, saya mengimplementasikan fitur registrasi akun di Flutter dengan membuat halaman formulir pendaftaran dan mengirim data ke endpoint registrasi Django menggunakan CookieRequest. Proses ini diikuti dengan pembuatan halaman login yang terhubung langsung dengan endpoint autentikasi Django, sehingga Flutter dapat menerima cookie sesi untuk mempertahankan status login.
Selanjutnya, saya melakukan integrasi autentikasi dengan memanfaatkan CookieRequest sebagai penyimpan cookie dan pengelola sesi. Instance ini kemudian disediakan secara global melalui Provider, sehingga seluruh halaman Flutter dapat mengakses status login pengguna, melakukan request terautentikasi, serta memanfaatkan cookie tanpa perlu melakukan konfigurasi ulang pada setiap komponen. Setelah autentikasi berjalan stabil, saya membuat model kustom di Flutter yang sesuai dengan struktur JSON di Django, sehingga proses parsing dan pengiriman data menjadi lebih aman, terstruktur, dan mudah dikelola.
Kemudian, saya membuat halaman daftar item yang mengambil data dari endpoint JSON Django. Pada halaman ini, saya menampilkan atribut penting seperti name, price, description, thumbnail, category, dan is_featured. Setiap item ditampilkan dalam bentuk card, dan ketika card ditekan, pengguna diarahkan ke halaman detail item. Pada halaman detail tersebut, seluruh atribut yang ada pada model ditampilkan kembali, dan tombol navigasi disediakan untuk kembali ke halaman daftar item.
Terakhir, saya mengimplementasikan fitur filter sehingga halaman daftar item hanya menampilkan data yang terasosiasi dengan pengguna yang sedang login. Filtering dilakukan baik melalui parameter request ke Django maupun dengan memanfaatkan endpoint yang hanya mengembalikan item milik user. Dengan seluruh elemen ini, checklist tugas dapat terpenuhi secara komprehensif dan aplikasi berjalan sesuai alur sistem autentikasi serta manajemen data yang telah ditentukan.
