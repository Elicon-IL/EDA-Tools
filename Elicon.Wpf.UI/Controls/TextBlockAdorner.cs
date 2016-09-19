using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;

namespace EdaTools.Controls
{

    public class TextBlockAdorner : Adorner
    {
        private readonly TextBlock _textBlock;

        // Be sure to call the base class constructor.
        public TextBlockAdorner(UIElement adornedElement, string hint, Style labelStyle)
            : base(adornedElement)
        {
            _textBlock = new TextBlock {Style = labelStyle, Text = hint};
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
