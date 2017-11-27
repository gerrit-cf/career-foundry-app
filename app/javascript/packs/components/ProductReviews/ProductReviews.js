import { h, render, Component } from 'preact'
import React from 'react'
import ReactStars from 'react-stars'

import ReviewForm from './ReviewForm'
// Todo: Make webpack resolve this shit properly
import { getCsrfToken } from '../../helpers'
import Cable from '../../actioncable/Cable'

export const initializeProductReviews = () => {
  const reviewsElement = document.getElementById('product-reviews')
  const reviewsIndexElements = document.getElementsByClassName('reviews__rating')

  for (const indexElement of reviewsIndexElements) {
    const rating = indexElement.dataset.rating

    render(
      <ReactStars
        count={5}
        edit={false}
        value={rating}
      />,
      indexElement,
      indexElement.lastChild
    )
  }

  if (reviewsElement) {
    render(<ProductReviews />, reviewsElement, reviewsElement.lastChild)
  }
}

const getAverageRating = data => parseFloat(data['average_rating'])
const getReviews = data => data['reviews'].data.map(review => ({ ...review.attributes, id: review.id }))
const getUserIsAdmin = () => gon.user.admin
const getUserIsSignedIn = () => gon.user['signed_in']
const getProductId = () => gon['reviewable_id']

const requestOptions = {
  method: 'delete',
  credentials: 'include',
  headers: {
    'Content-Type': 'application/json',
    'X_CSRF_TOKEN': getCsrfToken()
  }
}

const deleteResource = (productId, id) => `/products/${productId}/reviews/${id}.json`

class ProductReviews extends Component {
  state = {
    averageRating: getAverageRating(gon),
    newReview: false,
    productId: getProductId(),
    reviews: getReviews(gon),
    userIsAdmin: getUserIsAdmin(),
    userIsSignedIn: getUserIsSignedIn()
  }

  componentDidMount () {
    const { productId, userIsSignedIn } = this.state

    // Don't even bother the server again if not signed in
    if (!userIsSignedIn) return

    Cable.productSubscription = Cable.subscriptions.create('ProductChannel', {
      connected: function() {
        this.perform('listen', { 'product-id': productId })
      },
      received: (data) => {
        this.setState({
          averageRating: getAverageRating(data),
          newReview: true,
          reviews: getReviews(data)
        })
      }
    })
  }

  handleDeletedReview = (productId, data) => {
    this.setState({
      averageRating: getAverageRating(data),
      reviews: getReviews(data)
    })
  }

  deleteReview (productId, id) {
    let resource = deleteResource(productId, id)

    fetch(resource, requestOptions)
      .then(response => response.json())
      .then((json) => this.handleDeletedReview(productId, json))
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
    const { averageRating, productId, reviews } = this.state

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
        {reviews.length ?
          <a href={`/products/${productId}/reviews`}>Show all reviews</a> :
          null
        }
      </div>
    )
  }

  render = () => {
    const { newReview, productId, reviews, userIsSignedIn } = this.state

    return (
      <div className='product__reviews'>
        {newReview && <div className='alert alert-info'>A new review was posted.</div>}
        {reviews.length ? this.renderReviews() : 'There are no reviews yet.'}
        {userIsSignedIn ? <ReviewForm productId={productId} /> : null}
      </div>
    )
  }
}

export default ProductReviews
