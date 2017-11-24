import { h, render, Component } from 'preact'
import React from 'react'
import ReactStars from 'react-stars'

export const initializeProductReviews = () => {
  const reviewsElement = document.getElementById('product-reviews')

  if (!reviewsElement) return

  render(<ProductReviews />, reviewsElement, reviewsElement.lastChild)
}

const getReviews = () => gon['product_reviews'].data.map(review => review.attributes)

class ProductReviews extends Component {
  state = {
    reviews: getReviews()
  }

  renderReviews = () => {
    const { reviews } = this.state

    return reviews.map((review) => (
      <div className='reviews__review'>
        <strong>{review.name} </strong>
        <i>{review.timestamp}</i>
        <ReactStars
          className='reviews__rating'
          count={5}
          edit={false}
          value={review.rating}
        />
        <p>{review.comment}</p>
      </div>
    ))
  }

  render = () => {
    const { reviews } = this.state

    return (
      <div className='product__reviews'>
        {!reviews.length ? 'There are no reviews yet.' : this.renderReviews()}
      </div>
    )
  }
}

export default ProductReviews
