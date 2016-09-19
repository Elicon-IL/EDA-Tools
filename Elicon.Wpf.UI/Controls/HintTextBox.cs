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
        AdornerTextBlock _controlAdornerTextBlock;

        public override void OnApplyTemplate()
        {
            base.OnApplyTemplate();

            // Bind an adorner to the hint text-box.
            _controlAdornerLayer = AdornerLayer.GetAdornerLayer(this);
            _controlAdornerTextBlock = new AdornerTextBlock(this, HintText, TextBlockStyle);
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
                // Hide the hint Label.
                ToolTip = HintText;
                _controlAdornerLayer.Remove(_controlAdornerTextBlock);
            }
            else
            {
                // Show the hint Label.
                ToolTip = null;
                if (_controlAdornerLayer.GetAdorners(this) == null)
                    _controlAdornerLayer.Add(_controlAdornerTextBlock);

            }
        }
    }
}
