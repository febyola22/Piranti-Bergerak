import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Schedule',
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 42, 42, 40),
      ),
      home: CourseSchedule(),
    );
  }
}

class CourseSchedule extends StatelessWidget {
  const CourseSchedule({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Course Schedule',
            style: TextStyle(
              color: Colors.white, // Ubah warna teks judul AppBar di sini
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 74, 100, 139),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jumlah Jadwal Per Hari',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                // Check the screen width
                if (constraints.maxWidth >= 600) {
                  // Large screen: Keep Rabu inside Container
                  return Container(
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 163, 168, 186),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        BoxDay("Senin", "1"),
                        BoxDay("Selasa", "2"),
                        BoxDay("Rabu", "3"),
                        BoxDay("Kamis", "3"),
                        BoxDay("Jum'at", "2"),
                      ],
                    ),
                  );
                } else {
                  // Small screen (e.g., mobile): Use Stack to position Rabu
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 169, 176, 201),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            BoxDay("Senin", "1"),
                            BoxDay("Selasa", "2"),
                            BoxDay("Kamis", "3"),
                            BoxDay("Jum'at", "2"),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 26, // Adjust as needed
                        left: constraints.maxWidth * 0.44, // Adjust as needed
                        child: BoxDay("", "", isRabu: true), // Use isRabu
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 16),
            Text(
              'Jadwal Mata Kuliah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Expanded(
              child: CourseListView(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here when the button is clicked
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class BoxDay extends StatelessWidget {
  final String day;
  final String count;
  final bool isRabu; // Tambahkan properti untuk menandai Rabu

  BoxDay(this.day, this.count, {this.isRabu = false}); // Tambahkan parameter opsional

  @override
  Widget build(BuildContext context) {
    double width = isRabu ? 62 : 80; // Lebih kecil dan lebih panjang untuk Rabu
    double height = isRabu ? 90 : 80; // Lebih kecil dan lebih panjang untuk Rabu
    double imageWidth = 50; // Lebar gambar yang lebih kecil
    double imageHeight = 48; // Tinggi gambar yang lebih kecil
    Color boxColor = isRabu ? Color.fromARGB(255, 111, 181, 221) : Color(0xFFE0E0E0); // Warna hijau untuk Rabu, warna abu-abu lainnya

    // Tambahkan border hitam untuk hari Rabu, Selasa, dan Kamis
    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: boxColor, // Gunakan boxColor sesuai kondisi
    );

    if (isRabu || day == "Selasa" || day == "Kamis") {
      boxDecoration = boxDecoration.copyWith(
        border: Border.all(
          color: Colors.black, // Warna hitam untuk border
          width: 2.0, // Lebar border
        ),
      );
    }

    // Widget untuk menampilkan gambar pada hari Rabu
    Widget rabuImage = Image.asset(
      'assets/Rabu.png', // Ganti dengan path gambar Rabu yang sesuai
      width: imageWidth, // Sesuaikan ukuran gambar dengan yang lebih kecil
      height: imageHeight, // Sesuaikan ukuran gambar dengan yang lebih kecil
      fit: BoxFit.cover, // Sesuaikan gambar ke kotak
    );

    return Container(
      width: width,
      height: height,
      decoration: boxDecoration, // Gunakan boxDecoration yang telah disesuaikan
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          isRabu ? rabuImage : Text(day, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}



class Course {
  final String name;
  final String day;
  final String time;
  final String dosen;

  Course({
    required this.name,
    required this.day,
    required this.time,
    required this.dosen,
  });
}

class CourseListView extends StatelessWidget {
  final List<Course> courses = [
    Course(
      name: 'Febyola Pappang Allo',
      day: 'Senin',
      time: '11.30 - 13.00',
      dosen: 'Asisten Lab',
    ),
    Course(
      name: '2109106137',
      day: 'Selasa',
      time: '10.50 - 12.20',
      dosen: 'Dr. Anindita Septiarini, S.T., M.Cs',
    ),
    Course(
      name: 'Jaringan Komputer Lanjut',
      day: 'Selasa',
      time: '13.00 - 14.30',
      dosen: 'Gubtha Mahendra Putra, S.Kom., M.Eng',
    ),
    Course(
      name: 'Manajemen Proyek TI',
      day: 'Rabu',
      time: '07.30 - 16.00',
      dosen: 'Ummul Hairah, S.Pd., M.T',
    ),
    Course(
      name: 'Pemrograman Piranti Bergerak',
      day: 'Rabu',
      time: '10.50 - 12.20',
      dosen: 'Anton Prafanto, S.Kom., M.T',
    ),
    Course(
      name: 'Etika Profesi IT',
      day: 'Rabu',
      time: '13.00 - 14.30',
      dosen: 'Ir Novianti Puspitasari, S.Kom., M.Eng',
    ),
    Course(
      name: 'Praktikum Grafika Komputer',
      day: 'Kamis',
      time: '07.30 - 09.00',
      dosen: 'Asistem Lab',
    ),
    Course(
      name: 'Kecerdasan Buatan',
      day: 'Kamis',
      time: '10.50 - 12.20',
      dosen: 'Ir Novianti Puspitasari, S.Kom., M.Eng',
    ),
    Course(
      name: 'Grafika Komputer',
      day: 'Kamis',
      time: '13.00 - 14.30',
      dosen: 'Awang Harsa Kridalaksana, S.Kom., M.Kom',
    ),
    Course(
      name: 'Kecerdasan Buatan',
      day: 'Jum\'at',
      time: '09.40 - 11.40',
      dosen: 'Asisten Lab',
    ),
    Course(
      name: 'Probabilitas dan Statistika',
      day: 'Jum\'at',
      time: '13.30 - 15.00',
      dosen: 'Dr Fahrul Agus, S.Si., M.T',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        return CourseCard(course: courses[index]);
      },
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${course.day}, ${course.time}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              course.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Dosen: ${course.dosen}',
            ),
          ],
        ),
      ),
    );
  }
}
