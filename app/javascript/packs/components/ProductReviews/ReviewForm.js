
import { h, Component } from 'preact'
import ReactStars from 'react-stars'

// Todo: Make webpack resolve this shit properly
import { getCsrfToken } from '../../helpers'

class ReviewForm extends Component {
  state = {
    comment: '',
    rating: 0,
    success: false
  }

  handleRatingChange = rating => this.setState({ rating })

  handleCommentChange = ({ target: { value } }) => {
    this.setState({ comment: value })
  }

  handleSubmit = () => {
    const { comment, rating } = this.state
    const { productId } = this.props

    fetch(
      `/products/${productId}/reviews`,
      {
        body: JSON.stringify({ review: this.state }),
        credentials: 'include',
        headers: {
          'Content-Type': 'application/json',
          'X_CSRF_TOKEN': getCsrfToken()
        },
        method: 'POST'
      }
    ).then(this.handleSubmitSuccess)
  }

  handleSubmitSuccess = () => this.setState({ success: true })

  renderForm = () => {
    const { comment, rating, success } = this.state

    return (
      <div>
        <div className='form-group'>
          <label for='review-rating'>Rating</label>
          <ReactStars
            count={5}
            half={false}
            id='review-rating'
            onChange={this.handleRatingChange}
            value={rating}
          />
        </div>
        <div className='form-group'>
          <label for='review-comment'>Comment</label>
          <textarea
            className='form-control'
            id='review-comment'
            onChange={this.handleCommentChange}
            rows='6'
            value={comment}
          />
        </div>
        <button
          className='btn btn-primary'
          onClick={this.handleSubmit}
        >
          Submit
        </button>
      </div>
    )
  }

  render () {
    const { success } = this.state

    return (
      <div className='reviews__submit-form'>
        <h4>Submit a review</h4>
        {success ?
          <div>Thanks for submitting your review.</div> :
          this.renderForm()
        }
      </div>
    )
  }
}

export default ReviewForm
