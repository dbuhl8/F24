program avg_files

  implicit none

  integer, parameter :: num_files=9, num_lines=90
  integer :: i, j
  real :: time_per_step
  real, dimension(num_files):: avg_tpt
  character(len=12), dimension(num_files) :: files
  integer, dimension(num_files) :: np
  
  files = [character(len=12) :: "lr64.dat", &
    "lr128.dat", "lr256.dat", "lr512.dat", "lr1024.dat", &
    "hr256.dat", "hr512.dat", "hr1024.dat", "hr2048.dat"]
  np = [64, 128, 256, 512, 1024, 256, 512, 1024, 2048]

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
  do i = 1, 5
    write(30, "(I4,F8.3)")  np(i), avg_tpt(i)
  end do 
  write(30,*) 
  write(30,*) 
  do i = 6, num_files
    write(30, "(I4,F8.3)")  np(i), avg_tpt(i)
  end do 
  close(30)   

end program avg_files
