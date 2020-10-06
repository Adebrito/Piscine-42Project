let () =
  let tmp = "~{}usauhlorucaouhsnth:S~z" in
    print_endline "____________________";
    print_endline tmp;
    let tmp = (Cipher.rot42 tmp) in
    print_endline (tmp);
    print_endline (Uncipher.unrot42 tmp);
  let tmp = "absoasntuh~" in
    print_endline "____________________";
    print_endline tmp;
    let tmp = (Cipher.caesar 2 tmp) in
      print_endline tmp;
      print_endline (Uncipher.uncaesar 2 tmp);
  let tmp = "absoasntuh~" in
  print_endline "____________________";
  print_endline tmp;
  let tmp = (Cipher.caesar 15 tmp) in
    print_endline tmp;
    print_endline (Uncipher.uncaesar 15 tmp);
  let tmp = "Salut_toi_sa_va" in
    print_endline "____________________";
    print_endline tmp;
    let lst_func = [Cipher.rot42; Cipher.xor42;] in
      let new_tmp = (Cipher.ft_crypt tmp lst_func) in
        print_endline ("crypt " ^ new_tmp);
        print_endline (Uncipher.ft_uncrypt new_tmp lst_func)
    
