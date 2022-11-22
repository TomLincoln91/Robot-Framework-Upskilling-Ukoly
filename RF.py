def get_csv_rows(csvfile):
    file = open(csvfile)
    numline = len(file.readlines())
    return numline
