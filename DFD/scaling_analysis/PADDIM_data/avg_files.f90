program avg_files

  implicit none

  integer, parameter :: num_files=17, num_lines=95
  integer :: i, j
  real :: time_per_step
  real, dimension(num_files):: avg_tpt
  character(len=20), dimension(num_files) :: files, conf_text
  integer, dimension(num_files) :: np
  
  files = [character(len=20) :: "lr64.txt", &
    "lr128.txt", "lr256.txt", "lr256_16x16.txt", "lr512.txt", "lr1024.txt", &
    "hr256.txt", "hr512.txt", "hr1024.txt", "hr1024_16x64.txt","hr2048.txt",&
    "hr2048_16x128.txt", "hr2048_8x256.txt",&
    "llr32.txt", "llr64.txt", "llr128.txt", "llr256.txt"]
  np = [64, 128, 256, 256, 512, 1024,&
         256, 512, 1024, 1024, 2048, 2048, 2048,&
         32, 64, 128, 256]
  conf_text = [character(len=20) :: "8x8", &
    "8x16", "8x32","16x16", "16x32", "32x32", &
    "8x32", "16x32", "32x32", "16x64","32x64",&
    "16x128", "8x256",&
    "4x8", "8x8", "8x16", "16x16"]

  time_per_step = 0.
  avg_tpt = 0.

  do i = 1, num_files
    open(10+i, file=files(i))
    do j = 1, num_lines 
      read(10+i, *) time_per_step
      avg_tpt(i) = avg_tpt(i) + time_per_step
    end do
    close(10+i)
  end do 
  avg_tpt = avg_tpt/num_lines

  open(30, file="scaling.dat")
  write(30,*) "# Resolution: 256x256x64"
  write(30,*) "# np   tpt    config"
  do i = 1, 6
    write(30, "(I4,F8.3,'   ',A)")  np(i), avg_tpt(i), conf_text(i)
  end do 
  write(30,*) 
  write(30,*) "# Resolution: 512x512x128"
  write(30,*) "# np   tpt    config"
  do i = 7, 13
    write(30, "(I4,F8.3,'   ',A)")  np(i), avg_tpt(i), conf_text(i)
  end do 
  write(30,*) 
  write(30,*) "# Resolution: 128x128x32"
  write(30,*) "# np   tpt    config"
  do i = 14, num_files
    write(30, "(I4,F8.3,'   ',A)")  np(i), avg_tpt(i), conf_text(i)
  end do 
  close(30)   

end program avg_files
