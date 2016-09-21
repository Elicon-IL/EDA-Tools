using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Media;
using EdaTools.Utility;

namespace EdaTools.Controls
{
    public class HintTextBox : TextBox
    {

        AdornerLayer _hintTextBoxAdornerLayer;
        TextBlockAdorner _hintTextBlockAdorner;

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            // Bind the label adorner to the hint text-box.
            _hintTextBoxAdornerLayer = AdornerLayer.GetAdornerLayer(this);
            _hintTextBlockAdorner = new TextBlockAdorner(this, HintText, HintTextStyle);
            UpdateAdorner();

            // Attach the text-change event handler.
            var hasTextPropertyDescriptor = DependencyPropertyDescriptor.FromProperty(HasTextProperty, typeof(HintTextBox));
            hasTextPropertyDescriptor?.AddValueChanged(this, (sender, args) => UpdateAdorner());
        }

        public string HintText
        {
            get { return (string)GetValue(HintTextProperty); }
            set { SetValue(HintTextProperty, value); }
        }

        public static readonly DependencyProperty HintTextProperty = Utils.MakeStringDependencyProperty(typeof(HintTextBox), "HintText");

        public Style HintTextStyle
        {
            get { return (Style)GetValue(HintTextStyleProperty); }
            set { SetValue(HintTextStyleProperty, value); }
        }

        public static readonly DependencyProperty HintTextStyleProperty = Utils.MakeTypedDependencyProperty(typeof (HintTextBox), "HintTextStyle", typeof(Style));

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
                _hintTextBoxAdornerLayer.Remove(_hintTextBlockAdorner);
            }
            else
            {
                // Show the hint text.
                ToolTip = null;
                if (_hintTextBoxAdornerLayer.GetAdorners(this) == null)
                    _hintTextBoxAdornerLayer.Add(_hintTextBlockAdorner);

            }
        }

        private class TextBlockAdorner : Adorner
        {
            private readonly Border _border;
            private readonly TextBlock _textBlock;
            private readonly UIElement _owner;

            public TextBlockAdorner(UIElement owner, string hint, Style hintTextStyle)
                : base(owner)
            {
                _owner = owner;
                _textBlock = new TextBlock { Style = hintTextStyle, Text = hint, VerticalAlignment = VerticalAlignment.Center };
                _border = new Border { Child = _textBlock };
            }

            protected override Size MeasureOverride(Size constraint)
            {
                _textBlock.Measure(constraint);
                // This will make the adorner cover the whole owner control.
                return _owner.RenderSize;
            }

            protected override Size ArrangeOverride(Size finalSize)
            {
                _textBlock.Arrange(new Rect(finalSize));
                return finalSize;
            }

            protected override Visual GetVisualChild(int index)
            {
                return _border;
            }

            protected override int VisualChildrenCount => 1;
        }
    }
}
