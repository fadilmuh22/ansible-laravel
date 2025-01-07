# Panduan Pengaturan dan Menjalankan Proyek

Proyek ini dirancang untuk mengotomatisasi instalasi dan konfigurasi layanan Docker, Jenkins, dan MinIO menggunakan Ansible. Pengaturan ini menggunakan container Docker untuk pengujian dan penerapan.

## Prasyarat

- **Docker** (untuk pengujian menggunakan Dockerfile)
- **Ansible** (untuk manajemen konfigurasi)
- **SSH** akses ke sistem target (untuk eksekusi jarak jauh)

## Langkah Pengaturan

### 1. Clone Repository

Clone repository ke mesin lokal Anda:

```bash
git clone <url-repository-anda>
cd <folder-repository-anda>
```

### 2. Membangun dan Menguji dengan Docker (Opsional)

Untuk menguji pengaturan dalam lingkungan terisolasi, bangun dan jalankan container Docker:

```bash
docker build -t testing-image .
docker run -d -p 2222:22 --name testing-container testing-image
```

Pengaturan Docker ini mensimulasikan lingkungan tempat playbook Ansible dapat dijalankan. Ini dirancang hanya untuk tujuan pengujian.

### 3. Konfigurasi Ansible

Pastikan file-file berikut dikonfigurasi dengan benar untuk lingkungan Anda:

- **`ansible.cfg`**: Mendefinisikan inventaris dan menonaktifkan pengecekan kunci host.
- **`inventory.ini`**: Mendefinisikan detail koneksi SSH Anda.
- **`playbook.yml`**: Playbook utama yang mencakup roles untuk Docker, Jenkins, dan MinIO.

Pastikan file inventaris mengarah ke sistem target dengan user SSH dan file kunci pribadi yang benar.

### 4. Instal Ansible

Pastikan Anda sudah menginstal Ansible di mesin lokal Anda:

```bash
sudo apt install pipx
pipx install --include-deps ansible
```

### 5. Menjalankan Playbook Ansible

Jalankan playbook untuk mengonfigurasi lingkungan:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

Ini akan mengeksekusi tugas-tugas yang didefinisikan dalam `playbook.yml`, yang mencakup penerapan roles untuk Docker, Jenkins, dan MinIO ke sistem target.

### 6. Verifikasi Instalasi

- **Docker**: Jalankan `docker --version` untuk memastikan Docker terinstal.
- **Jenkins**: Kunjungi `http://<ip-sistem-target>:8080` untuk mengakses antarmuka web Jenkins.
- **MinIO**: Kunjungi `http://<ip-sistem-target>:9001` untuk mengakses konsol MinIO.

## Struktur Folder

- **Dockerfile**: Digunakan untuk menguji pengaturan dalam lingkungan terkontainerisasi.
- **ansible.cfg**: File konfigurasi untuk Ansible.
- **inventory.ini**: Mendefinisikan host target untuk dikelola oleh Ansible.
- **playbook.yml**: Playbook utama Ansible untuk menerapkan roles.
- **roles/**: Berisi roles individual untuk Docker, Jenkins, dan MinIO.
  - **tasks/main.yml**: Mendefinisikan tugas-tugas yang akan dijalankan untuk setiap role.
  - **files/**: Berisi file-file seperti Docker Compose dan definisi layanan untuk MinIO.
  - **defaults/main.yml**: Variabel default untuk setiap role.
  - **handlers/main.yml**: Handlers untuk restart layanan atau perubahan status.
  - **meta/main.yml**: Metadata untuk setiap role, termasuk dependensi dan informasi lisensi.

## Catatan

- **Dockerfile** hanya digunakan untuk menguji pengaturan dalam lingkungan terisolasi, di mana Anda dapat membangun dan menjalankan container dengan SSH yang diaktifkan.
- Pastikan layanan SSH sistem target sudah dikonfigurasi dengan benar dan dapat diakses oleh Ansible.


