﻿#pragma checksum "..\..\..\UcDoanhThu.xaml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "1FA9046B2CED9BB0B5AAAFD69CAA1EE181784123"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using LiveCharts.Wpf;
using QuanLiKhachSan;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Controls.Ribbon;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace QuanLiKhachSan {
    
    
    /// <summary>
    /// UcDoanhThu
    /// </summary>
    public partial class UcDoanhThu : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 65 "..\..\..\UcDoanhThu.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DatePicker dtpNgayBatDau;
        
        #line default
        #line hidden
        
        
        #line 72 "..\..\..\UcDoanhThu.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DatePicker dtgNgayKetThuc;
        
        #line default
        #line hidden
        
        
        #line 81 "..\..\..\UcDoanhThu.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button btnMotNamQua;
        
        #line default
        #line hidden
        
        
        #line 83 "..\..\..\UcDoanhThu.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button btn6ThangQua;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "7.0.4.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/QuanLiKhachSan;component/ucdoanhthu.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\UcDoanhThu.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "7.0.4.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.dtpNgayBatDau = ((System.Windows.Controls.DatePicker)(target));
            
            #line 67 "..\..\..\UcDoanhThu.xaml"
            this.dtpNgayBatDau.SelectedDateChanged += new System.EventHandler<System.Windows.Controls.SelectionChangedEventArgs>(this.dtpNgayBatDau_SelectedDateChanged);
            
            #line default
            #line hidden
            return;
            case 2:
            this.dtgNgayKetThuc = ((System.Windows.Controls.DatePicker)(target));
            
            #line 74 "..\..\..\UcDoanhThu.xaml"
            this.dtgNgayKetThuc.SelectedDateChanged += new System.EventHandler<System.Windows.Controls.SelectionChangedEventArgs>(this.dtgNgayKetThuc_SelectedDateChanged);
            
            #line default
            #line hidden
            return;
            case 3:
            this.btnMotNamQua = ((System.Windows.Controls.Button)(target));
            
            #line 82 "..\..\..\UcDoanhThu.xaml"
            this.btnMotNamQua.Click += new System.Windows.RoutedEventHandler(this.btnMotNamQua_Click);
            
            #line default
            #line hidden
            return;
            case 4:
            this.btn6ThangQua = ((System.Windows.Controls.Button)(target));
            
            #line 83 "..\..\..\UcDoanhThu.xaml"
            this.btn6ThangQua.Click += new System.Windows.RoutedEventHandler(this.btn6ThangQua_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

