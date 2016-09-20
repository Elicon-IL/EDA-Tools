using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using EdaTools.Utility;

namespace EdaTools.Controls
{
    public class HintTextBox : TextBox
    {

        AdornerLayer _hintTextBoxAdornerLayer;
        LabelAdorner _hintTextBoxLabelAdorner;

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            // Bind the label adorner to the hint text-box.
            _hintTextBoxAdornerLayer = AdornerLayer.GetAdornerLayer(this);
            _hintTextBoxLabelAdorner = new LabelAdorner(this, HintText, TextBlockStyle);
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
                _hintTextBoxAdornerLayer.Remove(_hintTextBoxLabelAdorner);
            }
            else
            {
                // Show the hint text.
                ToolTip = null;
                if (_hintTextBoxAdornerLayer.GetAdorners(this) == null)
                    _hintTextBoxAdornerLayer.Add(_hintTextBoxLabelAdorner);

            }
        }

        private class LabelAdorner : Adorner
        {
            private readonly Label _label;
            private readonly UIElement _owner;

            public LabelAdorner(UIElement owner, string hint, Style labelStyle)
                : base(owner)
            {
                _owner = owner;
                _label = new Label { Style = labelStyle, Content = hint };
            }

            protected override Size MeasureOverride(Size constraint)
            {
                _label.Measure(constraint);
                // This will make the adorner cover the whole owner control.
                return _owner.RenderSize;
            }

            protected override Size ArrangeOverride(Size finalSize)
            {
                _label.Arrange(new Rect(finalSize));
                return finalSize;
            }

            protected override System.Windows.Media.Visual GetVisualChild(int index)
            {
                return _label;
            }

            protected override int VisualChildrenCount => 1;
        }
    }
}
