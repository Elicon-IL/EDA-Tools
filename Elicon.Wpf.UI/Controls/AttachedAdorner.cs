using System.Windows;
using System.Windows.Documents;
using System.Windows.Media;

namespace EdaTools.Controls
{

    public class AttachedAdorner : Adorner
    {

        private readonly FrameworkElement _owner;
        private readonly FrameworkElement _element;

        public AttachedAdorner(FrameworkElement owner, FrameworkElement element)
            : base(owner)
        {
            _owner = owner;
            _element = element;
            _element.Focusable = false;
            AddVisualChild(_element);
        }

        protected override Size MeasureOverride(Size constraint)
        {
            _element.Measure(constraint);
            return _element.DesiredSize;
        }

        protected override Size ArrangeOverride(Size finalSize)
        {
            _element?.Arrange(new Rect(new Point(0, 0), _owner.DesiredSize));
            return finalSize;
        }

        protected override Visual GetVisualChild(int index)
        {
            return _element;
        }

        protected override int VisualChildrenCount => 1;

        #region Adorner attached property.
        public static readonly DependencyProperty AdornerProperty =
            DependencyProperty.RegisterAttached("Adorner", typeof(FrameworkElement), typeof(AttachedAdorner),
            new FrameworkPropertyMetadata(default(Spinner), PropertyChangedCallback));

        public static void SetAdorner(DependencyObject element, FrameworkElement value)
        {
            element.SetValue(AdornerProperty, value);
        }

        public static FrameworkElement GetAdorner(DependencyObject element)
        {
            return (FrameworkElement)element.GetValue(AdornerProperty);
        }

        private static void PropertyChangedCallback(DependencyObject dependencyObject,
            DependencyPropertyChangedEventArgs dependencyPropertyChangedEventArgs)
        {
            var frameworkElement = dependencyObject as FrameworkElement;
            if (frameworkElement != null)
            {
                frameworkElement.Loaded += AdornerLoaded;
            }
        }

        private static void AdornerLoaded(object sender, RoutedEventArgs e)
        {
            var frameworkElement = sender as FrameworkElement;
            if (frameworkElement != null)
            {
                var adornerLayer = AdornerLayer.GetAdornerLayer(frameworkElement);
                if (adornerLayer != null)
                {
                    // If GetSpinner() returns a type.
                    //x var spinner = (Spinner) Activator.CreateInstance(GetSpinner(frameworkElement)); //, frameworkElement);
                    var adorner = GetAdorner(frameworkElement);
                    SetAdorningElement(frameworkElement, adorner);
                    var attachedAdorner = new AttachedAdorner(frameworkElement, adorner);
                    adornerLayer.Add(attachedAdorner);
                 //x   adorner.Visibility = Visibility.Visible;
                }
            }
        }
        #endregion

        #region AdornerVisible attached property
        public static readonly DependencyProperty AdornerVisibleProperty = 
            DependencyProperty.RegisterAttached("AdornerVisible", typeof(bool), typeof(AttachedAdorner),
            new PropertyMetadata(false, AdornerVisibilityChanged));
        public static bool GetAdornerVisible(FrameworkElement target)
        {
            return (bool)target.GetValue(AdornerVisibleProperty);
        }
        public static void SetAdornerVisible(FrameworkElement target, bool value)
        {
            target.SetValue(AdornerVisibleProperty, value);
        }
        private static void AdornerVisibilityChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            var adorned = (FrameworkElement)d;
            var adorner = GetAdorningElement(adorned);
            if ((bool)e.NewValue)
                adorner.Visibility = Visibility.Visible;
            else
                adorner.Visibility = Visibility.Hidden;
            //x ((Spinner)adorner).SetVisible((bool)e.NewValue);

        }
        #endregion

        #region AdorningElement attached property
        public static readonly DependencyProperty AdorningElementProperty =
            DependencyProperty.RegisterAttached("AdorningElement", typeof(FrameworkElement), typeof(AttachedAdorner));

        public static FrameworkElement GetAdorningElement(DependencyObject target)
        {
            return (FrameworkElement)target.GetValue(AdorningElementProperty);
        }
        public static void SetAdorningElement(DependencyObject target, FrameworkElement value)
        {
            target.SetValue(AdorningElementProperty, value);
        }
        #endregion
    }

}
