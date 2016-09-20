using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using EdaTools.Utility;

namespace EdaTools.Controls
{
    public class HintTextBox : TextBox
    {

        AdornerLayer _controlAdornerLayer;
        TextBlockAdorner _controlTextBlockAdorner;

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            // Bind the text-block adorner to the hint text-box.
            _controlAdornerLayer = AdornerLayer.GetAdornerLayer(this);
            _controlTextBlockAdorner = new TextBlockAdorner(this, HintText, TextBlockStyle);
            UpdateAdorner();

            // Attach the text-change event handler.
            var containsTextProp = DependencyPropertyDescriptor.FromProperty(HasTextProperty, typeof(HintTextBox));
            containsTextProp?.AddValueChanged(this, (sender, args) => UpdateAdorner());
        }

        public string HintText
        {
            get { return (string)GetValue(HintTextProperty); }
            set { SetValue(HintTextProperty, value); }
        }

        public static readonly DependencyProperty HintTextProperty = Utils.MakeStringDependencyProperty(typeof(HintTextBox), "HintText");

        public Style TextBlockStyle
        {
            get { return (Style)GetValue(TextBlockStyleProperty); }
            set { SetValue(TextBlockStyleProperty, value); }
        }

        public static readonly DependencyProperty TextBlockStyleProperty = Utils.MakeTypedDependencyProperty(typeof (HintTextBox), "TextBlockStyle", typeof(Style));

        public bool HasText
        {
            get { return (bool)GetValue(HasTextProperty); }
            private set { SetValue(HasTextProperty, value); }
        }

        public static readonly DependencyProperty HasTextProperty = Utils.MakeBooleanDependencyProperty(typeof (HintTextBox), "HasText");


        protected override void OnTextChanged(TextChangedEventArgs e)
        {
            HasText = Text != "";
            base.OnTextChanged(e);
        }

        private void UpdateAdorner()
        {
            if (HasText)
            {
                // Hide the hint text.
                ToolTip = HintText;
                _controlAdornerLayer.Remove(_controlTextBlockAdorner);
            }
            else
            {
                // Show the hint text.
                ToolTip = null;
                if (_controlAdornerLayer.GetAdorners(this) == null)
                    _controlAdornerLayer.Add(_controlTextBlockAdorner);

            }
        }

        private class TextBlockAdorner : Adorner
        {
            private readonly TextBlock _textBlock;

            public TextBlockAdorner(UIElement adornedElement, string hint, Style textBlockStyle)
                : base(adornedElement)
            {
                _textBlock = new TextBlock { Style = textBlockStyle, Text = hint };
            }

            protected override Size MeasureOverride(Size constraint)
            {
                _textBlock.Measure(constraint);
                return constraint;
            }

            protected override Size ArrangeOverride(Size finalSize)
            {
                _textBlock.Arrange(new Rect(finalSize));
                return finalSize;
            }

            protected override System.Windows.Media.Visual GetVisualChild(int index)
            {
                return _textBlock;
            }

            protected override int VisualChildrenCount => 1;
        }
    }
}
