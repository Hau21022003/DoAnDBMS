   M S B A M L   `   `   `  ����I  EQuanLiKhachSan, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null/clr-namespace:QuanLiKhachSanQuanLiKhachSan  5           QuanLiKhachSan.UcThanhToan   5      W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      .localclr-namespace:QuanLiKhachSan     5        � 	Resources  5	       �� Source�� 5
   
   $ MyResourceDictionary.xaml?�6   %    .��5      �  � RowDefinitions 5   
   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      .+�5   
   � $��0��6    � ColumnDefinitions 5      �� 5      $
��auto �6#   �� 5      �� 5      $
��auto �6#   �� 5      �� 5      $
��auto �6#   �� 5      .+�5      �� $��0��6   .+�5      �� $��Mã bill��6   �� 5      $��Ngày tạo��6   �� 5       $��Mã đặt phòng��6   5!      �� 5"      $��1��6   .+�5#      �� -   5         ��Name$ lbMaBill��5#         	lbNoiDung#��[  6*   �� 5$      $��1��6   
�������$��1q�6<   ���	#FF959595 �� CornerRadius$ 10��5%   9   $��	20 5 20 5q�6K   ._�5&      (  "System.Windows.Controls.DatePicker  -   5          Name$ 
dtpNgayTao��5&   !   $��0q�5'   !   $��30��6,   
������ 
������ 6Q   5(      �� 5)      -   5         ��Name$ txtMaDatPhong��5)        
tbxNoiDung#��[ 61   5*      �� 5+      $��2��6   .+�5,      �� $��Chi phí phát sinh��6   �� 5-      $��Tổng phí��6   �� 5.      $��Mã nhân viên��6   5/      �� 50      $��3��6   .+�51      �� -   5        $ txtChiPhiPhatSinh��51      #��[ 52   "   �� 53      -   5        $ 
txtTongPhi��53      #��[ 54   "   �� 55      -   5        $ txtMaNhanVien��55      #��[ 61   56      �� 57      $��4��6   .+�58      �� $��Nội dung phát sinh��6   �� 59      $��Phương thức TT ��6   �� 5:      $��Ngày thanh toán��6   5;      �� 5<      $��5��6   .+�5=      �� -   5        $ txtNoiDungPhatSinh��5=      #��[ 66   �� 5>      -   5         ��Name$ cbHinhThucThanhToan��5>      	 �� SelectedValuePath$	 Content��68     	cbLuaChon#��[ 6T   .@�5?      �� $��Tiền mặt��6#   �� 5@      $��Chuyển khoản��6#   5A      �� 5B      $��1��6   
�������$��1q�6<   ���	#FF959595$ 10��5C   9   $��	20 5 20 5q�6K   ._�5D        -	   5        $ dtpNgayThanhToan��5D   !   $��0q�5E   !   $��30��6,   
������ 
������ 6Q   5F      5G      5H      � 5I   
   $��1��6    5J      �� 5K      �� 5L      .+�5N      �� -
   5        
 ��Name$
 btnThemBill��5N        btnThem#��[ 6*   6K   �� 5O      -   5        $
 
btnSuaBill��5O       
 btnSua#��[ 6)   $��1��6b   5P      �� 5Q   
   $��2��6     BorderPhanDoan#��[ 6   � 5R   
   $��3��6    5S      �� 5T      �� 5U      �� 5V      $
��auto �6#   .+�5X      �� -   5        #��[ 5X      $	 Content��6:   
 � Tag$) #Lọc theo trạng thái của bill��5Y      .@�5Z      �� $��
Tất cả��6   �� 5[      $��Đã thanh toán��6   �� 5\      $��Chưa thanh toán��6   5]      �� 5^      -   5        $��1��5^        tbxNoiDungMacDinh#��[ 5_      $ Tìm kiếm theo��5`       � ToolTip$ Tìm kiếm theo��5a      5b      �� 5c        
btnInExcel#��[ 6   $��2��69   5d      &   System.Windows.Controls.DataGrid  5e   
   -   5          Name$ dtgDanhSach��5e      $��4��6(      Columns 5f      4  .System.Windows.Controls.DataGridTemplateColumn  5g      ,  &System.Windows.Controls.DataGridColumn   Header$ Xử lí��6)      CellTemplate 5h      �� 5i      .R�5j      ��  �� Orientation$ 
Horizontal=�6)   .+�5k   "   �� $
 btnThongTinBill��6)   -   5          btnChinhSua#��[ 5l   1   �� 5m   "   $
 
btnXoaBill��6)   -   5         
	 btnXoa#��[	 5o   1   5p      5q      5s      0  *System.Windows.Controls.DataGridTextColumn  5t      $ Mã bill��6%   1  +System.Windows.Controls.DataGridBoundColumn   Binding 5u   -   �� *	bill_id+  5v      $ Tên khách đại diện��6%    5w   -   �� *customer_name+  5x      $ Mã đặt phòng��6%    5y   -   �� *booking_record_id+  5z      $ Tên nhân viên��6%    5{   -   �� *employee_name+  5|      $ Tổng phí��6%    5}   -   �� *
total_cost+  5~      $ Phí phát sinh��6%    5   -   �� *costs_incurred+  5�      $ Nội dung phát sinh��6%    5�   -   �� *content_incurred+  5�      $ Ngày tạo��6%    5�   -   �� *created_date+ �� StringFormat$ 
dd/MM/yyyy��  5�      $ Ngày thanh toán��6%    5�   -   �� *	paytime+$ 
dd/MM/yyyy��  5�      $! Phương thức thanh toán��6%    5�   -   �� *payment_method+5�      5�      5�      