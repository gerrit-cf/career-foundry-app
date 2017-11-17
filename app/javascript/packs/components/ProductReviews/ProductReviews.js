import { h, render, Component } from 'preact'

export const initializeProductReviews = () => {
  const reviewsElement = document.getElementById('product-reviews')

  if (!reviewsElement) return

  render(<ProductReviews />, reviewsElement, reviewsElement.lastChild)
}

class ProductReviews extends Component {
  state = {
    reviews: [{
      name: 'Gerrit',
      comment: 'I approve. 10 out of 10.',
      rating: 3
    }]
  }

  componentDidMount = () => this.fetchInitialReviews()

  fetchInitialReviews () {
    // TODO: Ajax call to get five initial reviews
  }

  renderReviews = () => {
    const { reviews } = this.state

    return reviews.map((review) => (
      <div className='reviews__review'>
        <strong>{review.name}</strong>
        <div className='reviews__rating'>{review.rating}</div>
        <p>{review.comment}</p>
      </div>
    ))
  }

  render () {
    const { reviews } = this.state

    return (
      <div className='product__reviews'>
        {!reviews.length ? 'There are no reviews yet.' : this.renderReviews()}
      </div>
    )
  }
}

export default ProductReviews
