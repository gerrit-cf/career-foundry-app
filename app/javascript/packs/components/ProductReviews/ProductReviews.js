import { h, render, Component } from 'preact'
import React from 'react'
import ReactStars from 'react-stars'

// Todo: Make webpack resolve this shit properly
import { getCsrfToken } from '../../helpers'

export const initializeProductReviews = () => {
  const reviewsElement = document.getElementById('product-reviews')

  if (!reviewsElement) return

  render(<ProductReviews />, reviewsElement, reviewsElement.lastChild)
}

const getAverageRating = data => parseFloat(data['average_rating'])
const getReviews = data => data['reviews'].data.map(review => ({ ...review.attributes, id: review.id }))
const getUserIsAdmin = data => data.user.admin

const requestOptions = {
  method: 'delete',
  credentials: 'include',
  headers: {
    'Content-Type': 'application/json',
    'X_CSRF_TOKEN': getCsrfToken()
  }
}

class ProductReviews extends Component {
  state = {
    averageRating: getAverageRating(gon),
    reviews: getReviews(gon),
    userIsAdmin: getUserIsAdmin(gon)
  }


  handleDeletedReview = (data, x) => {
    this.setState({
      averageRating: getAverageRating(data),
      reviews: getReviews(data)
    })
  }

  deleteReview (productId, id) {
    fetch(`/products/${productId}/reviews/${id}`, requestOptions)
      .then(response => response.json())
      .then(this.handleDeletedReview)

  }

  renderDeleteLink = (productId, id) => (
    <a
      children='Delete'
      href='#'
      onClick={(e) => {
        e.preventDefault()
        this.deleteReview(productId, id)
      }}
    />
  )

  renderReview (props) {
    const { userIsAdmin } = this.state
    const {
      comment,
      id,
      name,
      rating,
      'reviewable-id': reviewableId,
      timestamp,
    } = props

    return (
      <div className='reviews__review'>
        <strong>{name} </strong>
        <i>{timestamp}</i>
        <ReactStars
          className='reviews__rating'
          count={5}
          edit={false}
          value={rating}
        />
        <p>{comment}</p>
        {userIsAdmin ? this.renderDeleteLink(reviewableId, id) : null}
      </div>
    )
  }

  renderReviews = () => {
    const { averageRating, reviews } = this.state

    return (
      <div>
        <div className='reviews__overall-rating'>
          Overall product rating:
          <ReactStars
            count={5}
            edit={false}
            value={averageRating}
          />
        </div>
        {reviews.map(review => this.renderReview(review))}
      </div>
    )
  }

  render = () => {
    const { reviews } = this.state

    return (
      <div className='product__reviews'>
        {reviews.length ? this.renderReviews() : 'There are no reviews yet.'}
      </div>
    )
  }
}

export default ProductReviews
