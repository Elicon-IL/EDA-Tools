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

        public Spinner()
        {
            InitializeComponent();
            IsVisibleChanged += HandleVisibleChanged;
            _spinnerTimer = new DispatcherTimer(DispatcherPriority.Normal, Dispatcher) { Interval = new TimeSpan(0, 0, 0, 0, 120) };
            _circles = new Ellipse[9];
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
            for (var i = 0; i < 9; i++)
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
            SpinnerRotate.Angle = 0;
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
            SpinnerRotate.Angle = (SpinnerRotate.Angle + 36) % 360;
        }

        private static void SetCirclePosition(DependencyObject ellipse, double circleIndex)
        {
            ellipse.SetValue(Canvas.LeftProperty, 50.0 + (Math.Sin(Math.PI * ((0.2 * circleIndex) + 1)) * 50.0));
            ellipse.SetValue(Canvas.TopProperty, 50.0 + (Math.Cos(Math.PI * ((0.2 * circleIndex) + 1)) * 50.0));
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