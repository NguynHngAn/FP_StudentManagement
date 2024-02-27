class mon:
    def __init__(self, mmh, tenmh):
        self.mmh = mmh
        self.tenmh = tenmh

    def input_name_sub(self):
        print("------------------------------------------------------------------")
        print("Nhập môn học")
        self.mmh = input("Nhập mã môn học: ")
        self.tenmh = input("Nhập tên môn học: ")

    def print_name_sub(self):
        print("Mã số sinh viên: ", self.mmh)
        print("Họ tên: ", self.tenmh)








