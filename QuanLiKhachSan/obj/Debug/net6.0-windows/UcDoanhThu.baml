   M S B A M L   `   `   `  ����I  EQuanLiKhachSan, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null/clr-namespace:QuanLiKhachSanQuanLiKhachSan  5      U QLiveCharts.Wpf, Version=0.9.7.0, Culture=neutral, PublicKeyToken=0bc1f845d1ebb8dfG4clr-namespace:LiveCharts.Wpf;assembly=LiveCharts.WpfLiveCharts.Wpf 5          QuanLiKhachSan.UcDoanhThu   5      W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      .localclr-namespace:QuanLiKhachSan     5      Dlvc4clr-namespace:LiveCharts.Wpf;assembly=LiveCharts.Wpf     5      .��5
      �   � RowDefinitions  5   
   �� 5      $
��auto �6   �� 5      .+�5   
   �  � ColumnDefinitions 5      �� 5      $
��auto �6#   �� 5      .+�5      ��  �� CornerRadius$ 10��6   $��10q�6'   ���	#FFF9AB80._�5      ��  �� Orientation$ 
Horizontal=�6   .+�5      �� $��20(�6    $��Center=�6.   $��5 0 5 0q�6I   
Doanh thu:6g   �� 5      $��20(�6    $��5 0 5 0q�6L   $��Center=�6]   ��6.   �� *TongDoanhThu+6]   �� 5      $��20(�6    $��Center=�6.   $��2 0 5 0q�6I   đ6]   5      5      �� 5      $ 10��6   $��10q�6'   ���#C7D7FB$��1��6H    � 	Resources 5       �� 
TargetType �� BasedOn �� Property �� Value   
btnThongKe	 �� 
TargetType
 ��Name �� Triggers P� Property P� Value �� 
TargetName��%�  '��       7��&	  x     �� 5      " ��6   8   .�5      ��  � ��$ 17(�65   �� 5       � ��$ 	10 5 10 5q�63   5       �� 5!      " ��6   .�5"      ��  � ��$	 120��62   �� 5#       � ��$ 30��63   �� 5$       � ��$ 	10 5 10 5q�63   �� 5%       � �� 5&      �� 5'   "   "	 ��62   .R�5(   &   �� $
 border��6-   $ 10��6=   ���#8F89B7._�5)   *   �� $��Center=�6;   $��Center=�6X   $��5 0 0 0q�6s   
�������#��z��5*   ?   $��17(�6c   5+   '    5,   &   P� 5-   *    �@J�IsMouseOver$
 True��6I   . �5.   .   �� $ border��65    � �� �#3C284B6_   5/   +   51   #   53      54      55      ._�56      �  57      �� 58      $
��auto �6+   �� 59      $
��auto �6+   �� 5:      $
��auto �6+   �� 5;      $
��auto �6+   �� 5<      .+�5>      �� $��0��6   $��Từ:��6,   �� 5?      $��150px��6   $��1��6.   $��1q�6>   ���	#FF959595
�������$ 10��5@   )   $��0 5 10 5q�6;   ._�5A      (  "System.Windows.Controls.DatePicker  -   5          Name$ dtpNgayBatDau��5A   %   $��30��6<   $��0q�6H   
������ 
������    SelectedDate 5B   K   �� *
NgayBatDau+5C   1   5D      �� 5E      $��2��6   $��Đến:��6,   �� 5F      $��150px��6   $��3��6.   $��1q�6>   ���	#FF959595
�������$ 10��5G   )   $��0 5 10 5q�6;   ._�5H        -   5        $ dtgNgayKetThuc��5H   %   $��30��6=   $��0q�6I   
������ 
������  5I   K   �� *NgayKetThuc+5J   1   5K      � 5L      $��4��6    5M      �� 5N      �� 5O      .+�5Q      �� -   5         ��Name$ btnMotNamQua��5Q   1   $��0��6!   #��[  6G   $��Một năm qua��6k   5R   %   �� 5S      -   5        $ btn6ThangQua��5S   1   $��1��6!   #��[  5T   %   $��Sáu tháng qua��6I   5U      5W      5X      5Y      �� 5Z   
   $��10q�6   $ 20��6   ���#FFF9EC$��2��6D   ._�5[      #  LiveCharts.Wpf.CartesianChart  &   LiveCharts.Wpf.Charts.Base.Chart   LegendLocation$ Right=�6E      Series 6!   �� *SeriesCollection+   AxisX 5]        LiveCharts.Wpf.Axis     Title$ Mốc thời gian��6      Labels 65   �� *Labels+   AxisY 5`        $ Số lượng��6   5b      5c      5d      5e      