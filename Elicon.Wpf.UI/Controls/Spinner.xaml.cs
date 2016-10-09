using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace EdaTools.Controls
{
    public partial class Spinner
    {
        private readonly DispatcherTimer _spinnerTimer;
        private readonly Ellipse[] _circles;
        private readonly RadialGradientBrush _brush;
        private readonly RotateTransform _rotateTransform;
        private readonly bool _useOpacity;
        private int _offset;

        public Spinner()
        {
            InitializeComponent();
            IsVisibleChanged += HandleVisibleChanged;
            _spinnerTimer = new DispatcherTimer(DispatcherPriority.Send, Dispatcher) { Interval = new TimeSpan(0, 0, 0, 0, 180) };
            _useOpacity = true;
            _brush = new RadialGradientBrush
            {
                GradientOrigin = new Point(0.5, 0.5),
                Center = new Point(0.5, 0.5),
                RadiusX = 0.5,
                RadiusY = 0.5,
                GradientStops = new GradientStopCollection()
            };
            _brush.GradientStops.Add(new GradientStop(Colors.Transparent, 0.0));
            _brush.GradientStops.Add(new GradientStop(Color.FromRgb(90, 90, 90), 1.0));
            if (_useOpacity)
            {
                _circles = new Ellipse[10];
            }
            else
            {
                _circles = new Ellipse[9];
                _rotateTransform = new RotateTransform { Angle = 0 };
                Canvas1.RenderTransform = _rotateTransform;
            }
        }

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();
            CreateSpinnerCircles();
        }

        private void HandleUnloaded(object sender, RoutedEventArgs e)
        {
            Stop();
        }

        private void CreateSpinnerCircles()
        {
            for (var i = 0; i < _circles.Length; i++)
            {
                _circles[i] = new Ellipse
                {
                    Stretch = Stretch.Fill,
                    Width = 20,
                    Height = 20,
                    Fill = _brush,
                    Opacity = 1 - i * 0.11
                };
                Canvas1.Children.Add(_circles[i]);
                SetCirclePosition(_circles[i], i);
            }
        }

        private void UpdateCircles()
        {
            if (_useOpacity)
            {
                for (var i = 0; i < _circles.Length; i++)
                    _circles[i].Opacity = 1 - ((i + _offset) % _circles.Length) * 0.11;
                _offset = (_offset + 1) % _circles.Length;
            }
            else
                _rotateTransform.Angle = (_rotateTransform.Angle + 36) % 360;
            Canvas1.InvalidateVisual();
        }

        public void SetVisible(bool visible)
        {
            if (visible)
                Start();
            else
                Stop();
        }

        private void Start()
        {
            _spinnerTimer.Tick += OnSpinnerTick;
            _spinnerTimer.Start();
            if (_useOpacity)
                _offset = 0;
            else
                _rotateTransform.Angle = 0;
            Opacity = 1;
        }

        private void Stop()
        {
            _spinnerTimer.Stop();
            _spinnerTimer.Tick -= OnSpinnerTick;
            Opacity = 0;
        }

        private void OnSpinnerTick(object sender, EventArgs e)
        {
            UpdateCircles();
        }

        private static void SetCirclePosition(DependencyObject ellipse, double circleIndex)
        {
            ellipse.SetValue(Canvas.LeftProperty, 50.0 * (1 + Math.Sin(Math.PI * (1 + 0.2 * circleIndex))));
            ellipse.SetValue(Canvas.TopProperty, 50.0 * (1 + Math.Cos(Math.PI * (1 + 0.2 * circleIndex))));
        }

        public void HandleVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (System.ComponentModel.DesignerProperties.GetIsInDesignMode(this) == false)
            {
                if ((bool)e.NewValue)
                    Start();
                else
                    Stop();
            }
        }

    }
}